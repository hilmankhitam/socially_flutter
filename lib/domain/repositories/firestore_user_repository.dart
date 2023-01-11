import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/user_entity.dart';

abstract class FirestoreUserRepository {
  Future<Either<Failure, String>> addNewUser(UserEntity newUser);
  Future<Either<Failure, String>> updateUser(UserEntity updateUser);
  Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, List<UserEntity>>> searchUser(String query);
  Future<Either<Failure, String>> followThisUser(
      String myPersonalId, String followingUserId);
  Future<Either<Failure, String>> unfollowThisUser(
      String myPersonalId, String followingUserId);
}
