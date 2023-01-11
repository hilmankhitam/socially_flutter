import 'package:socially/common/exception.dart';
import 'package:socially/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:socially/data/datasources/remote/storage_methods.dart';
import 'dart:io';

import 'package:socially/domain/repositories/storage_methods_repository.dart';

class StorageMethodsRepositoryImpl implements StorageMethodsRepository {
  final StorageMethods storageMethods;

  StorageMethodsRepositoryImpl({required this.storageMethods});

  @override
  Future<Either<Failure, String>> uploadPostImage(File image) async {
    try {
      final result = await storageMethods.uploadPostImage(image);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }
}
