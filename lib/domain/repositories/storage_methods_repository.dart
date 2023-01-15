import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';

abstract class StorageMethodsRepository {
  Future<Either<Failure, String>> uploadPostImage(File image);
  Future<Either<Failure, String>> uploadChatImage(File image);
}
