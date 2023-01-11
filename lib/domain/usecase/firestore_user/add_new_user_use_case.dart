import 'package:dartz/dartz.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

import '../../../common/failure.dart';

class AddNewUserUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  AddNewUserUseCase(this.firestoreUserRepository);

  Future<Either<Failure, String>> execute(UserEntity user) {
    return firestoreUserRepository.addNewUser(user);
  }
}
