import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class UpdatePostUseCase {
  final FirestorePostRepository firestorePostRepository;

  UpdatePostUseCase(this.firestorePostRepository);

  Future<Either<Failure, String>> execute(String postImage, String idPost) {
    return firestorePostRepository.updatePost(postImage, idPost);
  }
}
