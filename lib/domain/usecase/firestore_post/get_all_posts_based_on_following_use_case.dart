import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class GetAllPostsBasedOnFollowingUseCase {
  final FirestorePostRepository firestorePostRepository;

  GetAllPostsBasedOnFollowingUseCase(this.firestorePostRepository);

  Future<Either<Failure, List<PostEntity>>> execute(
      List<String> following, String uid) {
    return firestorePostRepository.getFeedsBasedOnFollowing(following, uid);
  }
}
