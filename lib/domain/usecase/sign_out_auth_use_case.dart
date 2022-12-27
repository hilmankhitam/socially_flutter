import 'package:dartz/dartz.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';

import '../../common/failure.dart';

class SignOutAuthUseCase {
  final FirebaseAuthRepository firebaseAuthRepository;

  SignOutAuthUseCase(this.firebaseAuthRepository);

  Future<Either<Failure, String>> execute() {
    return firebaseAuthRepository.signOut();
  }
}
