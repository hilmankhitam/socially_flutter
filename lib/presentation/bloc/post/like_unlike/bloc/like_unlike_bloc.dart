import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/usecase/firestore_post/like_this_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/unlike_this_post_use_case.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final LikeThisPostUseCase likeThisPostUseCase;
  final UnlikeThisPostUseCase unlikeThisPostUseCase;

  LikeUnlikeBloc({
    required this.likeThisPostUseCase,
    required this.unlikeThisPostUseCase,
  }) : super(LikeUnlikeInitial()) {
    on<LikeThisPostEvent>((event, emit) async {
      try {
        final result =
            await likeThisPostUseCase.execute(event.idPost, event.idUser);

        await result.fold(
          (failure) async => emit(LikeUnlikeFailureState(failure.message)),
          (success) async => emit(LikeUnlikeSuccessState(success)),
        );
      } catch (error) {
        emit(LikeUnlikeFailureState(error.toString()));
      }
    });
    on<UnlikeThisPostEvent>((event, emit) async {
      try {
        final result =
            await unlikeThisPostUseCase.execute(event.idPost, event.idUser);

        await result.fold(
          (failure) async => emit(LikeUnlikeFailureState(failure.message)),
          (success) async => emit(LikeUnlikeSuccessState(success)),
        );
      } catch (error) {
        emit(LikeUnlikeFailureState(error.toString()));
      }
    });
  }
}
