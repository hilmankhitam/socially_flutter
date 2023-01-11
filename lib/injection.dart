import 'package:get_it/get_it.dart';
import 'package:socially/data/datasources/remote/firebase_auth.dart';
import 'package:socially/data/datasources/remote/firestore_chats.dart';
import 'package:socially/data/datasources/remote/firestore_posts.dart';
import 'package:socially/data/datasources/remote/firestore_user.dart';
import 'package:socially/data/datasources/remote/storage_methods.dart';
import 'package:socially/data/repositories/firebase_auth_repository_impl.dart';
import 'package:socially/data/repositories/firestore_chat_repository_impl.dart';
import 'package:socially/data/repositories/firestore_post_repository_impl.dart';
import 'package:socially/data/repositories/firestore_user_repository_impl.dart';
import 'package:socially/data/repositories/storage_methods_repository_impl.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';
import 'package:socially/domain/repositories/firestore_chat_repository.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';
import 'package:socially/domain/repositories/storage_methods_repository.dart';
import 'package:socially/domain/usecase/firestore_chat/add_message_use_case.dart';
import 'package:socially/domain/usecase/firestore_chat/get_messages_by_id_use_case.dart';
import 'package:socially/domain/usecase/firestore_chat/get_user_info_chat_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/add_new_comment_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/add_new_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/get_all_comments_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/get_all_posts_based_on_following_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/get_detail_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/get_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/like_this_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/unlike_this_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_post/update_post_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/add_new_user_use_case.dart';
import 'package:socially/domain/usecase/auth/auth_state_change_user_case.dart';
import 'package:socially/domain/usecase/auth/sign_in_auth_user_case.dart';
import 'package:socially/domain/usecase/auth/sign_out_auth_use_case.dart';
import 'package:socially/domain/usecase/auth/sign_up_auth_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/follow_this_user_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/get_user_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/search_user_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/unfollow_this_user_use_case.dart';
import 'package:socially/domain/usecase/firestore_user/update_user_use_case.dart';
import 'package:socially/domain/usecase/storage_methods/upload_post_image_use_case.dart';
import 'package:socially/presentation/bloc/chat/chat_bloc.dart';
import 'package:socially/presentation/bloc/chat/get_user_info_chat/get_user_info_chat_bloc.dart';
import 'package:socially/presentation/bloc/comment/comment_bloc.dart';
import 'package:socially/presentation/bloc/comment/get_comment/get_comment_bloc.dart';
import 'package:socially/presentation/bloc/firebase_auth/firebase_auth_bloc.dart';
import 'package:socially/presentation/bloc/follow_unfollow/follow_bloc.dart';
import 'package:socially/presentation/bloc/page/chat_page/chat_page_bloc.dart';
import 'package:socially/presentation/bloc/page/page_bloc.dart';
import 'package:socially/presentation/bloc/page/post_page/post_page_bloc.dart';
import 'package:socially/presentation/bloc/post/detail_post/detail_post_bloc.dart';
import 'package:socially/presentation/bloc/post/like_unlike/bloc/like_unlike_bloc.dart';
import 'package:socially/presentation/bloc/post/post_bloc.dart';
import 'package:socially/presentation/bloc/search/search_bloc.dart';
import 'package:socially/presentation/bloc/user/user_bloc.dart';

import 'domain/repositories/firestore_user_repository.dart';
import 'presentation/bloc/detail_profile_user/detail_profile_user_bloc.dart';
import 'presentation/bloc/page/profile_page/profile_page_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => PageBloc(),
  );
  locator.registerFactory(
    () => PostPageBloc(),
  );
  locator.registerFactory(
    () => ChatPageBloc(),
  );
  locator.registerFactory(
    () => ProfilePageBloc(),
  );
  locator.registerFactory(
    () => FirebaseAuthBloc(
      signUpAuthUseCase: locator(),
      signInAuthUseCase: locator(),
      signOutAuthUseCase: locator(),
      addNewUserUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => UserBloc(
      getUserUseCase: locator(),
      updateUserUseCase: locator(),
      getPostUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailProfileUserBloc(
      getUserUseCase: locator(),
      getPostUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      searchUserUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => FollowUnfollowBloc(
      followThisUserUseCase: locator(),
      unfollowThisUserUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => PostBloc(
      addNewPostUseCase: locator(),
      updatePostUseCase: locator(),
      uploadPostImageUseCase: locator(),
      getAllCommentsUseCase: locator(),
      getAllPostsBasedOnFollowingUseCase: locator(),
      getUserUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailPostBloc(
      getUserUseCase: locator(),
      getDetailPostUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => LikeUnlikeBloc(
      likeThisPostUseCase: locator(),
      unlikeThisPostUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => CommentBloc(
      addNewCommentUseCase: locator(),
      getUserUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => GetCommentsBloc(
      getAllCommentsUseCase: locator(),
      getUserUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => ChatBloc(
      addMessageUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => GetUserInfoChatBloc(
      getUserUseCase: locator(),
    ),
  );
  //usecase
  locator.registerLazySingleton(() => SignUpAuthUseCase(locator()));
  locator.registerLazySingleton(() => SignInAuthUseCase(locator()));
  locator.registerLazySingleton(() => SignOutAuthUseCase(locator()));
  locator.registerLazySingleton(() => AuthStateChangesUseCase(locator()));

  locator.registerLazySingleton(() => AddNewUserUseCase(locator()));
  locator.registerLazySingleton(() => GetUserUseCase(locator()));
  locator.registerLazySingleton(() => UpdateUserUseCase(locator()));
  locator.registerLazySingleton(() => SearchUserUseCase(locator()));

  locator.registerLazySingleton(() => FollowThisUserUseCase(locator()));
  locator.registerLazySingleton(() => UnfollowThisUserUseCase(locator()));

  locator.registerLazySingleton(() => AddNewPostUseCase(locator()));
  locator.registerLazySingleton(() => UpdatePostUseCase(locator()));
  locator.registerLazySingleton(() => GetPostUseCase(locator()));
  locator.registerLazySingleton(() => GetDetailPostUseCase(locator()));
  locator.registerLazySingleton(() => LikeThisPostUseCase(locator()));
  locator.registerLazySingleton(() => UnlikeThisPostUseCase(locator()));
  locator.registerLazySingleton(() => AddNewCommentUseCase(locator()));
  locator.registerLazySingleton(() => GetAllCommentsUseCase(locator()));
  locator.registerLazySingleton(
      () => GetAllPostsBasedOnFollowingUseCase(locator()));

  locator.registerLazySingleton(() => UploadPostImageUseCase(locator()));

  locator.registerLazySingleton(() => AddMessageUseCase(locator()));
  locator.registerLazySingleton(() => GetMessagesByIdUseCase(locator()));
  locator.registerLazySingleton(() => GetUserInfoChatUseCase(locator()));

  // repository
  locator.registerLazySingleton<FirebaseAuthRepository>(
    () => FirebaseAuthRepositoryImpl(
      firebaseAuthentication: locator(),
    ),
  );
  locator.registerLazySingleton<FirestoreUserRepository>(
    () => FirestoreUserRepositoryImpl(
      firestoreUser: locator(),
    ),
  );
  locator.registerLazySingleton<FirestorePostRepository>(
    () => FirestorePostRepositoryImpl(
      firestorePost: locator(),
    ),
  );
  locator.registerLazySingleton<StorageMethodsRepository>(
    () => StorageMethodsRepositoryImpl(
      storageMethods: locator(),
    ),
  );
  locator.registerLazySingleton<FirestoreChatRepository>(
    () => FirestoreChatRepositoryImpl(
      firestoreChat: locator(),
    ),
  );

  //data source
  locator.registerLazySingleton<FirebaseAuthentication>(
    () => FirebaseAuthenticationImpl(),
  );
  locator.registerLazySingleton<FirestoreUser>(
    () => FirestoreUserImpl(),
  );
  locator.registerLazySingleton<FirestorePost>(
    () => FirestorePostImpl(),
  );
  locator.registerLazySingleton<StorageMethods>(
    () => StorageMethodsImpl(),
  );
  locator.registerLazySingleton<FirestoreChat>(
    () => FirestoreChatImpl(),
  );
}
