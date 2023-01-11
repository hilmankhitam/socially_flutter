import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/common/extensions/extensions.dart';
import 'package:socially/domain/entities/registration_data.dart';
import 'package:socially/domain/entities/sign_in_data.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_user/add_new_user_use_case.dart';
import 'package:socially/domain/usecase/auth/sign_in_auth_user_case.dart';
import 'package:socially/domain/usecase/auth/sign_out_auth_use_case.dart';
import 'package:socially/domain/usecase/auth/sign_up_auth_use_case.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final SignUpAuthUseCase signUpAuthUseCase;
  final SignInAuthUseCase signInAuthUseCase;
  final SignOutAuthUseCase signOutAuthUseCase;
  final AddNewUserUseCase addNewUserUseCase;

  FirebaseAuthBloc({
    required this.signUpAuthUseCase,
    required this.signInAuthUseCase,
    required this.addNewUserUseCase,
    required this.signOutAuthUseCase,
  }) : super(FirebaseAuthInitial()) {
    on<FirebaseAuthSignUpEvent>((event, emit) async {
      emit(FirebaseAuthLoadingState());
      try {
        final result = await signUpAuthUseCase.execute(event.newUser);

        await result.fold((failure) async {
          emit(FirebaseAuthFailureState(failure.message.split(']')[1].trim()));
        }, (newUser) async {
          UserEntity user = newUser.convertToUser(
            name: event.newUser.name,
            username: event.newUser.username,
            dateOfBirth: event.newUser.dateOfBirth,
            gender: event.newUser.gender,
            about: event.newUser.about,
            profilePicture: '',
            isOnline: true,
            lastSeen: DateTime.now(),
          );
          final resultNewUser = await addNewUserUseCase.execute(user);
          await resultNewUser.fold((failure) async {
            emit(FirebaseAuthFailureState(failure.message));
          }, (message) async {
            emit(FirestoreUserSuccessState(message));
          });
          emit(FirebaseAuthSuccessState(newUser));
        });
      } catch (error) {
        emit(FirebaseAuthFailureState(error.toString().split(']')[1].trim()));
      }
    });

    on<FirebaseAuthSignInEvent>((event, emit) async {
      emit(FirebaseAuthLoadingState());
      try {
        final result = await signInAuthUseCase.execute(event.user);

        await result.fold((failure) async {
          emit(FirebaseAuthFailureState(failure.message.split(']')[1].trim()));
        }, (user) async {
          emit(FirebaseAuthSuccessState(user));
        });
      } catch (error) {
        emit(FirebaseAuthFailureState(error.toString().split(']')[1].trim()));
      }
    });

    on<FirebaseAuthSignOutEvent>((event, emit) async {
      try {
        final result = await signOutAuthUseCase.execute();
        await result.fold((failure) async {
          emit(FirebaseAuthFailureState(failure.message));
        }, (message) async {
          emit(FirestoreUserSuccessState(message));
        });
      } catch (error) {
        emit(FirebaseAuthFailureState(error.toString()));
      }
    });
  }
}
