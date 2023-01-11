part of 'detail_profile_user_bloc.dart';

abstract class DetailProfileUserEvent extends Equatable {
  const DetailProfileUserEvent();
}

class FetchDetailProfile extends DetailProfileUserEvent {
  final String uid;

  const FetchDetailProfile(this.uid);

  @override
  List<Object?> get props => [uid];
}

// class GetPostProfile extends DetailProfileUserEvent {
//   final String uid;

//   const GetPostProfile(this.uid);

//   @override
//   List<Object?> get props => [uid];
// }
