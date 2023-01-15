import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/common/extensions/extensions.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/domain/entities/message_data.dart';
import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_chat/get_messages_by_id_use_case.dart';
import 'package:socially/domain/usecase/firestore_chat/get_user_info_chat_use_case.dart';
import 'package:socially/presentation/bloc/chat/chat_bloc.dart';
import 'package:socially/presentation/bloc/chat/get_user_info_chat/get_user_info_chat_bloc.dart';
import 'package:socially/presentation/bloc/page/page_bloc.dart';
import 'package:socially/presentation/bloc/user/user_bloc.dart';
import 'package:socially/presentation/widgets/widgets.dart';
import 'package:socially/injection.dart' as di;

part 'chat_page.dart';
part 'detail_chat_page.dart';
