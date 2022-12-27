part of 'post_page_bloc.dart';

abstract class PostPageEvent extends Equatable {
  const PostPageEvent();
}

class GoToPostPage extends PostPageEvent {
  @override
  List<Object?> get props => [];
}

class GoToNotificationPage extends PostPageEvent {
  @override
  List<Object?> get props => [];
}

class GoToCommentPage extends PostPageEvent {
  @override
  List<Object?> get props => [];
}

class GoToSearchPage extends PostPageEvent {
  @override
  List<Object?> get props => [];
}
