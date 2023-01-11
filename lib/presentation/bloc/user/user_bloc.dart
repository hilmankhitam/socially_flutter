import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_post/get_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/update_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final GetPostUseCase getPostUseCase;

  UserBloc({
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.getPostUseCase,
  }) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      try {
        final result = await getUserUseCase.execute(event.id);

        await result
            .fold((failure) async => emit(UserFailureState(failure.message)),
                (user) async {
          List<PostEntity> posts = [];
          final resultGetPost = await getPostUseCase.execute(event.id);
          await resultGetPost.fold((failure) async {}, (resultPosts) async {
            posts = resultPosts;
          });
          emit(UserLoaded(user, posts));
        });
      } catch (error) {
        emit(UserFailureState(error.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      try {
        UserEntity updatedUser = (state as UserLoaded).user.copyWith(
              name: event.name,
              profilePicture: event.profilePicture,
              about: event.about,
              username: event.username,
              following: event.following,
              follower: event.follower,
              isOnline: event.isOnline,
              lastSeen: event.lastSeen,
            );
        final result = await updateUserUseCase.execute(updatedUser);
        await result.fold(
          (failure) async => emit(UserFailureState(failure.message)),
          (user) async {
            List<PostEntity> posts = [];
            final resultGetPost = await getPostUseCase.execute(updatedUser.id!);
            await resultGetPost.fold((failure) async {}, (resultPosts) async {
              posts = resultPosts;
            });
            emit(UserLoaded(updatedUser, posts));
          },
        );
      } catch (error) {
        emit(UserFailureState(error.toString()));
      }
    });
  }
}
