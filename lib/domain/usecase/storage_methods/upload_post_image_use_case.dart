import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/storage_methods_repository.dart';

class UploadPostImageUseCase {
  final StorageMethodsRepository storageMethodsRepository;

  UploadPostImageUseCase(this.storageMethodsRepository);

  Future<Either<Failure, String>> execute(File image) {
    return storageMethodsRepository.uploadPostImage(image);
  }
}
