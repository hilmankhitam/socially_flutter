import 'dart:io';

import 'package:socially/common/exception.dart';
import 'package:socially/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:socially/data/datasources/remote/firestore_chats.dart';
import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/repositories/firestore_chat_repository.dart';

class FirestoreChatRepositoryImpl implements FirestoreChatRepository {
  final FirestoreChat firestoreChat;

  FirestoreChatRepositoryImpl({required this.firestoreChat});

  @override
  Future<Either<Failure, String>> sendMessage(
      String reciverId, MessageEntity message) async {
    try {
      final result =
          await firestoreChat.sendMessage(reciverId, message.toModel());
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Stream<List<MessageEntity>> getMessagesById(
      String myPersonalId, String reciverId) {
    try {
      final result = firestoreChat.getMessagesById(myPersonalId, reciverId);
      return result
          .map((entity) => entity.map((model) => model.toEntity()).toList());
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Stream<List<String>> getUserInfoChat(String myPersonalId) {
    try {
      final result = firestoreChat.getUserInfoChat(myPersonalId);
      return result.map((listId) => listId.map((id) => id).toList());
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<Either<Failure, String>> updateRead(List<MessageEntity> messages,
      String receiverId, String myPersonalId) async {
    try {
      final result = await firestoreChat.updateRead(
        messages.map((entity) => entity.toModel()).toList(),
        receiverId,
        myPersonalId,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }
}
