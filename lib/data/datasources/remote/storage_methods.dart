import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageMethods {
  Future<String> uploadPostImage(File image);
}

class StorageMethodsImpl implements StorageMethods {
  static final Reference referencePost =
      FirebaseStorage.instance.ref().child('posts');
  static final Reference referenceProfile =
      FirebaseStorage.instance.ref().child('profile');

  @override
  Future<String> uploadPostImage(File image) async {
    String path = image.path;
    String fileName = DateTime.now().toIso8601String() + p.basename(path);
    Reference ref = referencePost.child(fileName);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
