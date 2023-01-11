import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

class UpdateUserUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  UpdateUserUseCase(this.firestoreUserRepository);

  Future<Either<Failure, String>> execute(UserEntity user) {
    return firestoreUserRepository.updateUser(user);
  }
}
