import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:socially/common/shared_value.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/domain/entities/registration_data.dart';
import 'package:socially/domain/entities/sign_in_data.dart';
import 'package:socially/presentation/bloc/firebase_auth/firebase_auth_bloc.dart';
import 'package:socially/presentation/bloc/page/page_bloc.dart';
import 'package:socially/presentation/widgets/widgets.dart';

part 'sign_in_page.dart';
part 'sign_up_confirmation_page.dart';
part 'sign_up_personal_information_page.dart';
part 'sign_up_username_page.dart';
