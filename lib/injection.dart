import 'package:get_it/get_it.dart';
import 'package:socially/data/datasources/remote/firebase_auth.dart';
import 'package:socially/data/datasources/remote/firestore_user.dart';
import 'package:socially/data/repositories/firebase_auth_repository_impl.dart';
import 'package:socially/data/repositories/firestore_user_repository_impl.dart';
import 'package:socially/domain/repositories/firebase_auth_repository.dart';
import 'package:socially/domain/usecase/add_new_user_user_case.dart';
import 'package:socially/domain/usecase/auth_state_change_user_case.dart';
import 'package:socially/domain/usecase/sign_in_auth_user_case.dart';
import 'package:socially/domain/usecase/sign_out_auth_use_case.dart';
import 'package:socially/domain/usecase/sign_up_auth_use_case.dart';
import 'package:socially/presentation/bloc/chat/chat_page_bloc.dart';
import 'package:socially/presentation/bloc/firebase_auth/firebase_auth_bloc.dart';
import 'package:socially/presentation/bloc/page_bloc.dart';
import 'package:socially/presentation/bloc/post/post_page_bloc.dart';

import 'domain/repositories/firestore_user_repository.dart';

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
    () => FirebaseAuthBloc(
      signUpAuthUseCase: locator(),
      signInAuthUseCase: locator(),
      signOutAuthUseCase: locator(),
      addNewUserUseCase: locator(),
    ),
  );
  //usecase
  locator.registerLazySingleton(() => SignUpAuthUseCase(locator()));
  locator.registerLazySingleton(() => SignInAuthUseCase(locator()));
  locator.registerLazySingleton(() => SignOutAuthUseCase(locator()));
  locator.registerLazySingleton(() => AddNewUserUseCase(locator()));
  locator.registerLazySingleton(() => AuthStateChangesUseCase(locator()));

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

  //data source
  locator.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthenticationImpl());
  locator.registerLazySingleton<FirestoreUser>(() => FirestoreUserImpl());
}
