import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_post/get_detail_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';

part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  final GetDetailPostUseCase getDetailPostUseCase;
  final GetUserUseCase getUserUseCase;

  DetailPostBloc({
    required this.getDetailPostUseCase,
    required this.getUserUseCase,
  }) : super(DetailPostInitial()) {
    on<FetchDetailPostEvent>((event, emit) async {
      emit(DetailPostLoadingState());

      try {
        final resultDetailPost =
            await getDetailPostUseCase.execute(event.idPost);
        await resultDetailPost.fold(
            (failure) async => emit(DetailPostFailureState(failure.message)),
            (detailPost) async {
          UserEntity userPost = UserEntity();
          List<UserEntity> likes = [];
          final resultUser = await getUserUseCase.execute(detailPost.idUser);
          await resultUser.fold((failure) async => {}, (user) async {
            userPost = user;
          });

          for (int index = 0;
              index <
                  (detailPost.likes.length >= 3 ? 3 : detailPost.likes.length);
              index++) {
            final resultUser =
                await getUserUseCase.execute(detailPost.likes[index]);
            await resultUser.fold((failure) async => null, (user) async {
              likes.add(user);
            });
          }

          emit(DetailPostSuccessState(userPost, detailPost, likes));
        });
      } catch (error) {
        emit(DetailPostFailureState(error.toString()));
      }
    });
  }
}
