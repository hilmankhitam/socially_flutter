import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class AddNewCommentUseCase {
  final FirestorePostRepository firestorePostRepository;

  AddNewCommentUseCase(this.firestorePostRepository);

  Future<Either<Failure, CommentEntity>> execute(
      String idPost, String idUser, String comment) {
    return firestorePostRepository.addComment(idPost, idUser, comment);
  }
}
