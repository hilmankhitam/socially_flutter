import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';

part 'get_user_info_chat_event.dart';
part 'get_user_info_chat_state.dart';

class GetUserInfoChatBloc
    extends Bloc<GetUserInfoChatEvent, GetUserInfoChatState> {
  final GetUserUseCase getUserUseCase;

  GetUserInfoChatBloc({
    required this.getUserUseCase,
  }) : super(GetUserInfoChatInitial()) {
    on<GetUserInfoByIdEvent>((event, emit) async {
      emit(GetUserInfoChatLoadingState());
      try {
        List<UserEntity> users = [];
        for (int index = 0; index < event.uids.length; index++) {
          final result = await getUserUseCase.execute(event.uids[index]);
          await result.fold(
            (failure) async => null,
            (user) async {
              users.add(user);
            },
          );
        }
        emit(GetUserInfoChatSuccessState(users));
      } catch (error) {
        emit(GetUserInfoChatFailureState(error.toString()));
      }
    });
  }
}
