import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/sign_in_data.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';

class SignInAuthUseCase {
  final FirebaseAuthRepository firebaseAuthRepository;

  SignInAuthUseCase(this.firebaseAuthRepository);

  Future<Either<Failure, User>> execute(SignInData user) {
    return firebaseAuthRepository.signIn(user);
  }
}
