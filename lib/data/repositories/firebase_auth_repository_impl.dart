import 'dart:io';

import 'package:socially/data/datasources/remote/firebase_auth.dart';
import 'package:socially/common/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:socially/domain/entities/registration_data.dart';
import 'package:socially/domain/entities/sign_in_data.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';

import '../../common/exception.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthentication firebaseAuthentication;

  FirebaseAuthRepositoryImpl({required this.firebaseAuthentication});

  @override
  Future<Either<Failure, User>> signUp(RegistrationData newUser) async {
    try {
      final result =
          await firebaseAuthentication.signUp(newUser.email, newUser.password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(SignInData user) async {
    try {
      final result =
          await firebaseAuthentication.signIn(user.email, user.password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      final result = await firebaseAuthentication.signOut();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Stream<User?> get userStream => firebaseAuthentication.userStream;
}
