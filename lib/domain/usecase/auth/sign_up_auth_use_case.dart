import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/registration_data.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';

class SignUpAuthUseCase {
  final FirebaseAuthRepository firebaseAuthRepository;

  SignUpAuthUseCase(this.firebaseAuthRepository);

  Future<Either<Failure, User>> execute(RegistrationData newUser) {
    return firebaseAuthRepository.signUp(newUser);
  }
}
