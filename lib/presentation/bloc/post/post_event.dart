part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class AddPostEvent extends PostEvent {
  final PostData post;

  const AddPostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends PostEvent {
  final String postImage;
  final String idPost;

  const UpdatePostEvent(this.postImage, this.idPost);
  @override
  List<Object?> get props => [postImage, idPost];
}

class GetAllPostsBasedOnFollowing extends PostEvent {
  final List<String> following;
  final String uid;

  const GetAllPostsBasedOnFollowing(this.following, this.uid);

  @override
  List<Object?> get props => [following, uid];
}
