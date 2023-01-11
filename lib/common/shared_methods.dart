import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

Future<String> uploadProfileImage(File image) async {
  String path = image.path;
  String fileName = DateTime.now().toIso8601String() + p.basename(path);

  Reference ref =
      FirebaseStorage.instance.ref().child('profile').child(fileName);

  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task.whenComplete(() {});

  return await snapshot.ref.getDownloadURL();
}

Future<String> uploadPostImage(File image) async {
  String path = image.path;
  String fileName = DateTime.now().toIso8601String() + p.basename(path);

  Reference ref = FirebaseStorage.instance.ref().child('posts').child(fileName);

  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task.whenComplete(() {});

  return await snapshot.ref.getDownloadURL();
}
