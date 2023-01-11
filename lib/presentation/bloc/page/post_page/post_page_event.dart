part of 'post_page_bloc.dart';

abstract class PostPageEvent extends Equatable {
  const PostPageEvent();
}

class GoToPostPageInitial extends PostPageEvent {
  @override
  List<Object?> get props => [];
}

class GoToPostPage extends PostPageEvent {
  final List<String> following;

  const GoToPostPage(this.following);
  @override
  List<Object?> get props => [following];
}

class GoToNotificationPage extends PostPageEvent {
  @override
  List<Object?> get props => [];
}

class GoToCommentPostPage extends PostPageEvent {
  final String idPost;
  final List<PostPageEvent> pop;

  const GoToCommentPostPage(this.idPost, this.pop);

  @override
  List<Object?> get props => [idPost, pop];
}

class GoToSearchPage extends PostPageEvent {
  final List<PostPageEvent> pop;

  const GoToSearchPage(this.pop);

  @override
  List<Object?> get props => [pop];
}

class GoToDetailProfilePage extends PostPageEvent {
  final String uid;
  final List<PostPageEvent> pop;

  const GoToDetailProfilePage(this.uid, this.pop);
  @override
  List<Object?> get props => [uid, pop];
}

class GoToProfilePostPage extends PostPageEvent {
  final List<PostPageEvent> pop;

  const GoToProfilePostPage(this.pop);
  @override
  List<Object?> get props => [pop];
}
