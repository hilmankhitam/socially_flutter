import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/registration_data.dart';
import 'package:socially/domain/entities/user_entity.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    //on<GoToSplashPage>((event, emit) => emit(OnSplashPage()));
    on<GoToSignInPage>((event, emit) => emit(OnSignInPage()));
    on<GoToSignUpPersonalPage>(
        (event, emit) => emit(OnSignUpPersonalPage(event.registrationData)));
    on<GoToSignUpUsernamePage>(
        (event, emit) => emit(OnSignUpUsernamePage(event.registrationData)));
    on<GoToSignUpConfirmationPage>((event, emit) =>
        emit(OnSignUpConfirmationPage(event.registrationData)));
    on<GoToMainPage>(
        (event, emit) => emit(OnMainPage(event.bottomNavBarIndex)));
    on<GoToDetailChatPage>((event, emit) => emit(OnDetailChatPage(event.user)));
  }
}
