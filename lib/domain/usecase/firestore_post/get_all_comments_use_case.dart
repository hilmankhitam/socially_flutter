import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class GetAllCommentsUseCase {
  final FirestorePostRepository firestorePostRepository;

  GetAllCommentsUseCase(this.firestorePostRepository);

  Future<Either<Failure, List<CommentEntity>>> execute(String idPost) {
    return firestorePostRepository.getAllComments(idPost);
  }
}
