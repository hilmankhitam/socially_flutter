import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/data/models/comment_model.dart';
import 'package:socially/data/models/models.dart';

abstract class FirestorePost {
  Future<String> addPost(PostModel post);
  Future<String> updatePost(String postImage, String idPost);
  Future<List<PostModel>> getPost(String uid);
  Future<PostModel> getDetailPost(String idPost);
  Future<CommentModel> addComment(String idPost, String idUser, String comment);
  Future<List<CommentModel>> getAllComments(String idPost);
  Future<String> likeThisPost(String idPost, String idUser);
  Future<String> unlikeThisPost(String idPost, String idUser);
  Future<List<PostModel>> getFeedsBasedOnFollowing(
      List<String> following, String uid);
}

class FirestorePostImpl implements FirestorePost {
  static final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('posts');

  @override
  Future<String> addPost(PostModel post) async {
    DocumentReference addPost = _firebaseFirestore.doc();
    await addPost.set({
      'idPost': addPost.id,
      'idUser': post.idUser,
      'description': post.description,
      'hastag': post.hastag,
      'datePublished': post.datePublished.millisecondsSinceEpoch,
      'likes': post.likes,
      'postImage': post.postImage,
    });

    return 'Successfully added a post';
  }

  @override
  Future<String> updatePost(String postImage, String idPost) async {
    await _firebaseFirestore.doc(idPost).update({
      'postImage': postImage,
    });
    return 'successfully updated a post';
  }

  @override
  Future<List<PostModel>> getPost(String uid) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.where('idUser', isEqualTo: uid).get();

    return snapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      PostModel post = PostModel.fromJson(data);
      return post;
    }).toList();
  }

  @override
  Future<PostModel> getDetailPost(String idPost) async {
    DocumentSnapshot snapshot = await _firebaseFirestore.doc(idPost).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return PostModel.fromJson(data);
  }

  @override
  Future<CommentModel> addComment(
      String idPost, String idUser, String comment) async {
    DocumentReference addComment =
        _firebaseFirestore.doc(idPost).collection('comments').doc();
    await addComment.set({
      'commentId': addComment.id,
      'idUser': idUser,
      'comment': comment,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });

    DocumentSnapshot snapshot = await _firebaseFirestore
        .doc(idPost)
        .collection('comments')
        .doc(addComment.id)
        .get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return CommentModel.fromJson(data);
  }

  @override
  Future<List<CommentModel>> getAllComments(String idPost) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.doc(idPost).collection('comments').get();
    return snapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      return CommentModel.fromJson(data);
    }).toList();
  }

  @override
  Future<String> likeThisPost(String idPost, String idUser) async {
    await _firebaseFirestore.doc(idPost).update({
      'likes': FieldValue.arrayUnion([idUser]),
    });
    return 'Successfully like this post';
  }

  @override
  Future<String> unlikeThisPost(String idPost, String idUser) async {
    await _firebaseFirestore.doc(idPost).update({
      'likes': FieldValue.arrayRemove([idUser]),
    });
    return 'Successfully unlike this post';
  }

  @override
  Future<List<PostModel>> getFeedsBasedOnFollowing(
      List<String> following, String uid) async {
    List<PostModel> posts = [];
    for (int index = 0; index < following.length; index++) {
      QuerySnapshot snapshot = await _firebaseFirestore
          .where('idUser', isEqualTo: following[index])
          .get();
      snapshot.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        posts.add(PostModel.fromJson(data));
      }).toList();
    }
    QuerySnapshot snapshot =
        await _firebaseFirestore.where('idUser', isEqualTo: uid).get();
    snapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      posts.add(PostModel.fromJson(data));
    }).toList();
    posts.sort((a, b) => b.datePublished.compareTo(a.datePublished));
    return posts;
  }
}
