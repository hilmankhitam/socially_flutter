import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_post/add_new_comment_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddNewCommentUseCase addNewCommentUseCase;
  final GetUserUseCase getUserUseCase;

  CommentBloc({
    required this.addNewCommentUseCase,
    required this.getUserUseCase,
  }) : super(CommentInitial()) {
    on<AddNewCommentEvent>((event, emit) async {
      emit(CommentLoadingState());
      try {
        final result = await addNewCommentUseCase.execute(
            event.idPost, event.idUser, event.comment);
        await result.fold(
          (failure) async => emit(CommentFailureState(failure.message)),
          (comment) async {
            UserEntity user = UserEntity();
            final resultUser = await getUserUseCase.execute(comment.idUser!);

            await resultUser.fold(
                (failure) async => emit(CommentFailureState(failure.message)),
                (resultUser) async {
              user = resultUser;
            });
            emit(CommentSuccessState(comment, user));
          },
        );
      } catch (error) {
        emit(CommentFailureState(error.toString()));
      }
    });
    on<CommentInitialEvent>((event, emit) => emit(CommentInitial()));
  }
}
