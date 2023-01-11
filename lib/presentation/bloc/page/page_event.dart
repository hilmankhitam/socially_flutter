part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

// class GoToSplashPage extends PageEvent {
//   @override
//   List<Object?> get props => [];
// }

class GoToSignInPage extends PageEvent {
  @override
  List<Object?> get props => [];
}

class GoToSignUpPersonalPage extends PageEvent {
  final RegistrationData registrationData;

  const GoToSignUpPersonalPage(this.registrationData);

  @override
  List<Object?> get props => [];
}

class GoToSignUpUsernamePage extends PageEvent {
  final RegistrationData registrationData;

  const GoToSignUpUsernamePage(this.registrationData);
  @override
  List<Object?> get props => [];
}

class GoToSignUpConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  const GoToSignUpConfirmationPage(this.registrationData);
  @override
  List<Object?> get props => [];
}

class GoToMainPage extends PageEvent {
  final int bottomNavBarIndex;
  const GoToMainPage(this.bottomNavBarIndex);
  @override
  List<Object?> get props => [];
}

class GoToDetailChatPage extends PageEvent {
  final UserEntity user;

  const GoToDetailChatPage(this.user);

  @override
  List<Object?> get props => [user];
}
