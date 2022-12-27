part of 'firebase_auth_bloc.dart';

abstract class FirebaseAuthState extends Equatable {
  const FirebaseAuthState();
}

class FirebaseAuthInitial extends FirebaseAuthState {
  @override
  List<Object?> get props => [];
}

class FirebaseAuthLoadingState extends FirebaseAuthState {
  @override
  List<Object?> get props => [];
}

class FirebaseAuthSuccessState extends FirebaseAuthState {
  final User user;

  const FirebaseAuthSuccessState(this.user);
  @override
  List<Object?> get props => [];
}

class FirestoreUserSuccessState extends FirebaseAuthState {
  final String message;

  const FirestoreUserSuccessState(this.message);
  @override
  List<Object?> get props => [];
}

class FirebaseAuthFailureState extends FirebaseAuthState {
  final String message;

  const FirebaseAuthFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
