import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_post/get_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';

part 'detail_profile_user_event.dart';
part 'detail_profile_user_state.dart';

class DetailProfileUserBloc
    extends Bloc<DetailProfileUserEvent, DetailProfileUserState> {
  final GetUserUseCase getUserUseCase;
  final GetPostUseCase getPostUseCase;

  DetailProfileUserBloc({
    required this.getUserUseCase,
    required this.getPostUseCase,
  }) : super(DetailProfileUserLoading()) {
    on<FetchDetailProfile>((event, emit) async {
      emit(DetailProfileUserLoading());
      try {
        final resultGetUser = await getUserUseCase.execute(event.uid);
        await resultGetUser.fold(
            (failure) async => emit(DetailProfileUserError(failure.message)),
            (resultUser) async {
          UserEntity user = resultUser;
          List<PostEntity> posts = [];
          List<UserEntity> followers = [];
          final resultGetPost = await getPostUseCase.execute(event.uid);
          await resultGetPost.fold((failure) async {}, (resultPosts) async {
            posts = resultPosts;
          });

          if (user.follower!.isNotEmpty) {
            for (int index = 0;
                index <
                    (user.follower!.length >= 10 ? 10 : user.follower!.length);
                index++) {
              final resultGetFollower =
                  await getUserUseCase.execute(user.follower![index]);
              await resultGetFollower.fold((failure) async => null,
                  (follower) async {
                followers.add(follower);
              });
            }
          }

          emit(DetailProfileUserSuccess(user, posts, followers));
        });
      } catch (error) {
        emit(DetailProfileUserError(error.toString()));
      }
    });
  }
}
