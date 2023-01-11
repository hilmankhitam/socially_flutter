import 'package:firebase_auth/firebase_auth.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';

class AuthStateChangesUseCase {
  final FirebaseAuthRepository firebaseAuthRepository;

  AuthStateChangesUseCase(this.firebaseAuthRepository);

  Stream<User?> get execute => firebaseAuthRepository.userStream;
}
