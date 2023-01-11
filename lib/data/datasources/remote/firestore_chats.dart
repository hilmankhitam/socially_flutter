import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/data/models/models.dart';

abstract class FirestoreChat {
  Future<String> sendMessage(String receiverId, MessageModel message);
  Stream<List<MessageModel>> getMessagesById(
      String myPersonalId, String receiverId);
  Stream<List<String>> getUserInfoChat(String myPersonalId);
}

class FirestoreChatImpl implements FirestoreChat {
  static final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  @override
  Future<String> sendMessage(String receiverId, MessageModel message) async {
    await _firebaseFirestore
        .doc(message.senderId)
        .collection('chats')
        .doc(receiverId)
        .set({'empty': receiverId});
    await _firebaseFirestore
        .doc(receiverId)
        .collection('chats')
        .doc(message.senderId)
        .set({'idUser': message.senderId});
    DocumentReference<Map<String, dynamic>> chatSender = _firebaseFirestore
        .doc(message.senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc();
    DocumentReference<Map<String, dynamic>> chatReciver = _firebaseFirestore
        .doc(receiverId)
        .collection('chats')
        .doc(message.senderId)
        .collection('messages')
        .doc();
    await chatSender.set(message.toJson());
    await chatReciver.set(message.toJson());
    return 'successfully sent a message';
  }

  @override
  Stream<List<MessageModel>> getMessagesById(
      String myPersonalId, String receiverId) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshotsMessages =
        _firebaseFirestore
            .doc(myPersonalId)
            .collection("chats")
            .doc(receiverId)
            .collection("messages")
            .snapshots();
    return snapshotsMessages.map((snapshot) =>
        snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> json) {
          MessageModel message = MessageModel.fromJson(json);
          return message;
        }).toList());
  }

  @override
  Stream<List<String>> getUserInfoChat(String myPersonalId) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshotsMessages =
        _firebaseFirestore.doc(myPersonalId).collection("chats").snapshots();
    return snapshotsMessages
        .map((snapshot) => snapshot.docs.map((QueryDocumentSnapshot data) {
              String id = data.id;
              return id;
            }).toList());
  }
}
