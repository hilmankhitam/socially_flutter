part of 'firebase_auth_bloc.dart';

abstract class FirebaseAuthEvent extends Equatable {
  const FirebaseAuthEvent();
}

class FirebaseAuthSignUpEvent extends FirebaseAuthEvent {
  final RegistrationData newUser;

  const FirebaseAuthSignUpEvent(this.newUser);

  @override
  List<Object?> get props => [];
}

class FirebaseAuthSignInEvent extends FirebaseAuthEvent {
  final SignInData user;
  const FirebaseAuthSignInEvent(this.user);
  @override
  List<Object?> get props => [];
}

class FirebaseAuthSignOutEvent extends FirebaseAuthEvent {
  @override
  List<Object?> get props => [];
}
