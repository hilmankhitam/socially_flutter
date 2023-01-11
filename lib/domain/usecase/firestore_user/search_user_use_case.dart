import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

class SearchUserUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  SearchUserUseCase(this.firestoreUserRepository);

  Future<Either<Failure, List<UserEntity>>> execute(String query) {
    return firestoreUserRepository.searchUser(query);
  }
}
