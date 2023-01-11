import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class GetDetailPostUseCase {
  final FirestorePostRepository firestorePostRepository;

  GetDetailPostUseCase(this.firestorePostRepository);

  Future<Either<Failure, PostEntity>> execute(String idPost) {
    return firestorePostRepository.getDetailPost(idPost);
  }
}
