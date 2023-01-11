import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';

class SignOutAuthUseCase {
  final FirebaseAuthRepository firebaseAuthRepository;

  SignOutAuthUseCase(this.firebaseAuthRepository);

  Future<Either<Failure, String>> execute() {
    return firebaseAuthRepository.signOut();
  }
}
