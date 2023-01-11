import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:socially/domain/usecase/auth/auth_state_change_user_case.dart';
import 'package:socially/presentation/bloc/chat/chat_bloc.dart';
import 'package:socially/presentation/bloc/chat/get_user_info_chat/get_user_info_chat_bloc.dart';
import 'package:socially/presentation/bloc/comment/comment_bloc.dart';
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
import 'injection.dart' as di;

import 'presentation/bloc/comment/get_comment/get_comment_bloc.dart';
import 'presentation/bloc/detail_profile_user/detail_profile_user_bloc.dart';
import 'presentation/bloc/page/profile_page/profile_page_bloc.dart';
import 'presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: di.locator<AuthStateChangesUseCase>().execute,
      initialData: null,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<PageBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PostPageBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ChatPageBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ProfilePageBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FirebaseAuthBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<UserBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DetailProfileUserBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SearchBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FollowUnfollowBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PostBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DetailPostBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<LikeUnlikeBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CommentBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GetCommentsBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ChatBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GetUserInfoChatBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Socially",
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF006175),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          home: const Wrapper(),
        ),
      ),
    );
  }
}
