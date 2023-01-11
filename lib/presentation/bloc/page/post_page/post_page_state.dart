part of 'post_page_bloc.dart';

abstract class PostPageState extends Equatable {
  const PostPageState();
}

class PostPageInitial extends PostPageState {
  @override
  List<Object?> get props => [];
}

class OnPostPage extends PostPageState {
  final List<String> following;

  const OnPostPage(this.following);
  @override
  List<Object?> get props => [following];
}

class OnNotificationPage extends PostPageState {
  @override
  List<Object?> get props => [];
}

class OnCommentPostPage extends PostPageState {
  final String idPost;
  final List<PostPageEvent> pop;

  const OnCommentPostPage(this.idPost, this.pop);

  @override
  List<Object?> get props => [idPost, pop];
}

class OnSearchPage extends PostPageState {
  final List<PostPageEvent> pop;
  const OnSearchPage(this.pop);
  @override
  List<Object?> get props => [pop];
}

class OnDetailProfilePage extends PostPageState {
  final String uid;
  final List<PostPageEvent> pop;

  const OnDetailProfilePage(this.uid, this.pop);

  @override
  List<Object?> get props => [uid, pop];
}

class OnProfilePostPage extends PostPageState {
  final List<PostPageEvent> pop;

  const OnProfilePostPage(this.pop);

  @override
  List<Object?> get props => [pop];
}
