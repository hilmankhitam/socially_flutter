import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

class FollowThisUserUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  FollowThisUserUseCase(this.firestoreUserRepository);

  Future<Either<Failure, String>> execute(
      String myPersonalId, String followingUserId) {
    return firestoreUserRepository.followThisUser(
        myPersonalId, followingUserId);
  }
}
