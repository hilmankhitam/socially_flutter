import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_page_event.dart';
part 'post_page_state.dart';

class PostPageBloc extends Bloc<PostPageEvent, PostPageState> {
  PostPageBloc() : super(PostPageInitial()) {
    on<GoToPostPageInitial>((event, emit) => emit(PostPageInitial()));
    on<GoToPostPage>((event, emit) => emit(OnPostPage(event.following)));
    on<GoToNotificationPage>((event, emit) => emit(OnNotificationPage()));
    on<GoToCommentPostPage>(
        (event, emit) => emit(OnCommentPostPage(event.idPost, event.pop)));
    on<GoToSearchPage>((event, emit) => emit(OnSearchPage(event.pop)));
    on<GoToDetailProfilePage>(
        (event, emit) => emit(OnDetailProfilePage(event.uid, event.pop)));
    on<GoToProfilePostPage>(
        (event, emit) => emit(OnProfilePostPage(event.pop)));
  }
}
