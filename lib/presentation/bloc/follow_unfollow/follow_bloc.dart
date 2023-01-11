import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/usecase/firestore_user/follow_this_user_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/unfollow_this_user_use_case.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  final FollowThisUserUseCase followThisUserUseCase;
  final UnfollowThisUserUseCase unfollowThisUserUseCase;

  FollowUnfollowBloc({
    required this.followThisUserUseCase,
    required this.unfollowThisUserUseCase,
  }) : super(FollowUnfollowLoadingState()) {
    on<FollowUserEvent>((event, emit) async {
      emit(FollowUnfollowLoadingState());
      try {
        final resultFollowThisUser = await followThisUserUseCase.execute(
            event.myPersonalId, event.followingUserId);

        await resultFollowThisUser.fold(
          (failure) async => emit(FollowUnfollowErrorState(failure.message)),
          (message) async => emit(FollowUnfollowSuccessState(message)),
        );
      } catch (_) {}
    });
    on<UnfollowUserEvent>((event, emit) async {
      emit(FollowUnfollowLoadingState());
      try {
        final resultUnfollowThisUser = await unfollowThisUserUseCase.execute(
            event.myPersonalId, event.followingUserId);

        await resultUnfollowThisUser.fold(
          (failure) async => emit(FollowUnfollowErrorState(failure.message)),
          (message) async => emit(FollowUnfollowSuccessState(message)),
        );
      } catch (_) {}
    });
  }
}
