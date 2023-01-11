import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<GoToProfilePageInitial>((event, emit) => emit(ProfilePageInitial()));
    on<GoToProfileProfilePage>((event, emit) => emit(OnProfileProfilePage()));
    on<GoToCommentProfilePage>(
        (event, emit) => emit(OnCommentProfilePage(event.idPost, event.pop)));
  }
}
