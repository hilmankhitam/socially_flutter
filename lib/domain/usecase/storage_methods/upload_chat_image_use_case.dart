import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/repositories/storage_methods_repository.dart';

class UploadChatImageUseCase {
  final StorageMethodsRepository storageMethodsRepository;

  UploadChatImageUseCase(this.storageMethodsRepository);

  Future<Either<Failure, String>> execute(File image) {
    return storageMethodsRepository.uploadChatImage(image);
  }
}
