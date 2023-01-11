import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class UnlikeThisPostUseCase {
  final FirestorePostRepository firestorePostRepository;

  UnlikeThisPostUseCase(this.firestorePostRepository);

  Future<Either<Failure, String>> execute(String idPost, String idUser) {
    return firestorePostRepository.unlikeThisPost(idPost, idUser);
  }
}
