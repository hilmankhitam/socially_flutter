part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class PageInitial extends PageState {
  @override
  List<Object?> get props => [];
}

// class OnSplashPage extends PageState {
//   @override
//   List<Object?> get props => [];
// }

class OnSignInPage extends PageState {
  @override
  List<Object?> get props => [];
}

class OnSignUpPersonalPage extends PageState {
  final RegistrationData registrationData;

  const OnSignUpPersonalPage(this.registrationData);

  @override
  List<Object?> get props => [];
}

class OnSignUpUsernamePage extends PageState {
  final RegistrationData registrationData;

  const OnSignUpUsernamePage(this.registrationData);
  @override
  List<Object?> get props => [];
}

class OnSignUpConfirmationPage extends PageState {
  final RegistrationData registrationData;

  const OnSignUpConfirmationPage(this.registrationData);
  @override
  List<Object?> get props => [];
}

class OnMainPage extends PageState {
  final int bottomNavBarIndex;
  const OnMainPage(this.bottomNavBarIndex);
  @override
  List<Object?> get props => [];
}

class OnDetailChatPage extends PageState {
  final UserEntity user;

  const OnDetailChatPage(this.user);
  @override
  List<Object?> get props => [user];
}
