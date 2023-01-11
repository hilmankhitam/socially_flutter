import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

class UnfollowThisUserUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  UnfollowThisUserUseCase(this.firestoreUserRepository);

  Future<Either<Failure, String>> execute(
      String myPersonalId, String followingUserId) {
    return firestoreUserRepository.unfollowThisUser(
        myPersonalId, followingUserId);
  }
}
