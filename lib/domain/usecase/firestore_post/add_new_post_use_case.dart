import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class AddNewPostUseCase {
  final FirestorePostRepository firestorePostRepository;

  AddNewPostUseCase(this.firestorePostRepository);

  Future<Either<Failure, String>> execute(PostEntity post) {
    return firestorePostRepository.addPost(post);
  }
}
