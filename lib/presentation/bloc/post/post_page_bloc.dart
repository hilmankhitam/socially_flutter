import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_page_event.dart';
part 'post_page_state.dart';

class PostPageBloc extends Bloc<PostPageEvent, PostPageState> {
  PostPageBloc() : super(PostPageInitial()) {
    on<GoToPostPage>((event, emit) => emit(OnPostPage()));
    on<GoToNotificationPage>((event, emit) => emit(OnNotificationPage()));
    on<GoToCommentPage>((event, emit) => emit(OnCommentPage()));
    on<GoToSearchPage>((event, emit) => emit(OnSearchPage()));
  }
}
