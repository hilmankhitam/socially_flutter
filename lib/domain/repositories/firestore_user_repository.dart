import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/user_entity.dart';

abstract class FirestoreUserRepository {
  Future<Either<Failure, String>> addNewUser(UserEntity newUser);
}
