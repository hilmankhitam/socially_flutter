import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/registration_data.dart';
import 'package:socially/domain/entities/sign_in_data.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, User>> signUp(RegistrationData newUser);
  Future<Either<Failure, User>> signIn(SignInData user);
  Future<Either<Failure, String>> signOut();
  Stream<User?> get userStream;
}
