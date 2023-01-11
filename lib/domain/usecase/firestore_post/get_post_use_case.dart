import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class GetPostUseCase {
  final FirestorePostRepository firestorePostRepository;

  GetPostUseCase(this.firestorePostRepository);

  Future<Either<Failure, List<PostEntity>>> execute(String uid) {
    return firestorePostRepository.getPost(uid);
  }
}
