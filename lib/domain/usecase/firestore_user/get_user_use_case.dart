import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

class GetUserUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  GetUserUseCase(this.firestoreUserRepository);

  Future<Either<Failure, UserEntity>> execute(String id) {
    return firestoreUserRepository.getUser(id);
  }
}
