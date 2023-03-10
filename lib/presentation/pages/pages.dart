import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:socially/common/shared_value.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/presentation/bloc/page/page_bloc.dart';
import 'package:socially/presentation/bloc/page/post_page/post_page_bloc.dart';
import 'package:socially/presentation/bloc/page/profile_page/profile_page_bloc.dart';
import 'package:socially/presentation/bloc/post/post_bloc.dart';
import 'package:socially/presentation/bloc/user/user_bloc.dart';
import 'package:socially/presentation/pages/auth/auth.dart';
import 'package:socially/presentation/pages/chat/chat.dart';
import 'package:socially/presentation/pages/post/post.dart';
import 'package:socially/presentation/pages/profile/profile_page.dart';
import 'package:socially/presentation/pages/social/social_page.dart';
import 'package:socially/presentation/pages/upload/upload_page.dart';

part 'wrapper.dart';
part 'splash_screen.dart';
part 'main_page.dart';
