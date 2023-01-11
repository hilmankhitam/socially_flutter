import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/entities/post_data.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_post/add_new_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/get_all_comments_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/get_all_posts_based_on_following_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/update_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';
import 'package:socially/domain/usecase/storage_methods/upload_post_image_use_case.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AddNewPostUseCase addNewPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;
  final GetAllPostsBasedOnFollowingUseCase getAllPostsBasedOnFollowingUseCase;
  final GetUserUseCase getUserUseCase;
  final GetAllCommentsUseCase getAllCommentsUseCase;

  PostBloc({
    required this.addNewPostUseCase,
    required this.updatePostUseCase,
    required this.uploadPostImageUseCase,
    required this.getAllPostsBasedOnFollowingUseCase,
    required this.getUserUseCase,
    required this.getAllCommentsUseCase,
  }) : super(PostInitial()) {
    on<AddPostEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final resultUpload =
            await uploadPostImageUseCase.execute(event.post.postImage!);
        await resultUpload
            .fold((failure) async => PostFailureState(failure.message),
                (downloadUrl) async {
          PostEntity post = PostEntity(
            idUser: event.post.idUser!,
            description: event.post.description!,
            hastag: event.post.hastag!,
            datePublished: event.post.datePublished!,
            likes: event.post.likes!,
            postImage: downloadUrl,
          );
          final result = await addNewPostUseCase.execute(post);

          await result.fold(
            (failure) async => emit(PostFailureState(failure.message)),
            (success) async => emit(PostSuccessState(success)),
          );
        });
      } catch (error) {
        emit(PostFailureState(error.toString()));
      }
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final result =
            await updatePostUseCase.execute(event.postImage, event.idPost);
        await result.fold(
          (failure) async => emit(PostFailureState(failure.message)),
          (success) async => emit(UpdatePostSuccessState(success)),
        );
      } catch (error) {
        emit(PostFailureState(error.toString()));
      }
    });

    on<GetAllPostsBasedOnFollowing>((event, emit) async {
      emit(GetPostsBasedFollowingLoadingState());
      try {
        final result = await getAllPostsBasedOnFollowingUseCase.execute(
            event.following, event.uid);

        await result.fold(
          (failure) async =>
              emit(GetPostsBasedFollowingFailureState(failure.message)),
          (resultPosts) async {
            List<PostEntity> posts = resultPosts;
            List<UserEntity> users = [];
            List<List<UserEntity>> likes = [];
            List<List<CommentEntity>> comments = [];

            for (int index = 0; index < posts.length; index++) {
              //get user info post
              final resultUser =
                  await getUserUseCase.execute(posts[index].idUser);
              await resultUser.fold((failure) async => null, (user) async {
                users.add(user);
              });

              //get comments
              final resultComments =
                  await getAllCommentsUseCase.execute(posts[index].idPost!);
              await resultComments.fold((_) async => null, (resultComment) {
                comments.insert(index, resultComment);
              });

              // get likes info
              List<UserEntity> resultLikeUsers = [];
              for (int indexLikes = 0;
                  indexLikes <
                      (posts[index].likes.length >= 3
                          ? 3
                          : posts[index].likes.length);
                  indexLikes++) {
                final resultLikes = await getUserUseCase
                    .execute(posts[index].likes[indexLikes]);
                await resultLikes.fold((_) async => null, (likesUser) async {
                  resultLikeUsers.add(likesUser);
                });
              }
              likes.insert(index, resultLikeUsers);
            }

            emit(GetPostsBasedFollowingSuccessState(
              posts,
              users,
              likes,
              comments,
            ));
          },
        );
      } catch (error) {
        emit(GetPostsBasedFollowingFailureState(error.toString()));
      }
    });
  }
}
