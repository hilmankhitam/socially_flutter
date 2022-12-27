import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:socially/domain/usecase/auth_state_change_user_case.dart';
import 'package:socially/presentation/bloc/chat/chat_page_bloc.dart';
import 'package:socially/presentation/bloc/firebase_auth/firebase_auth_bloc.dart';
import 'package:socially/presentation/bloc/page_bloc.dart';
import 'package:socially/presentation/bloc/post/post_page_bloc.dart';
import 'injection.dart' as di;

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
            create: (_) => di.locator<FirebaseAuthBloc>(),
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
