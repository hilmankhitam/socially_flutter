import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_post/get_all_comments_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';

part 'get_comment_event.dart';
part 'get_comment_state.dart';

class GetCommentsBloc extends Bloc<GetCommentEvent, GetCommentsState> {
  final GetAllCommentsUseCase getAllCommentsUseCase;
  final GetUserUseCase getUserUseCase;
  GetCommentsBloc({
    required this.getAllCommentsUseCase,
    required this.getUserUseCase,
  }) : super(GetCommentInitial()) {
    on<GetAllCommentEvent>((event, emit) async {
      emit(GetCommentLoadingState());

      try {
        final result = await getAllCommentsUseCase.execute(event.idPost);

        await result.fold(
          (failure) async => emit(GetCommentFailureState(failure.message)),
          (comments) async {
            List<CommentEntity> resultcomments = comments;
            List<UserEntity> users = [];
            for (int index = 0; index < resultcomments.length; index++) {
              final resultUser =
                  await getUserUseCase.execute(comments[index].idUser!);
              await resultUser.fold(
                  (failure) async =>
                      emit(GetCommentFailureState(failure.message)), (user) {
                users.add(user);
              });
            }

            emit(GetCommentSuccessState(
              resultcomments,
              users,
            ));
          },
        );
      } catch (error) {
        emit(GetCommentFailureState(error.toString()));
      }
    });
  }
}
