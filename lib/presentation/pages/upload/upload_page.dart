import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/domain/entities/post_data.dart';
import 'package:socially/presentation/bloc/post/post_bloc.dart';
import 'package:socially/presentation/widgets/widgets.dart';

class UploadPage extends StatefulWidget {
  final String idUser;
  const UploadPage({required this.idUser, super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  PostData post = PostData();
  CroppedFile? _croppedFile;

  Future<void> getAndCropImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Widget _image() {
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return GestureDetector(
        onTap: () => getAndCropImage(),
        child: Container(
          height: 133,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => getAndCropImage(),
        child: Container(
          height: 133,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: const Color(0xFF006175),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/add_image_upload_icon.png',
              width: 25,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    captionsController.dispose();
    hastagsController.dispose();
    super.dispose();
  }

  TextEditingController captionsController = TextEditingController();
  TextEditingController hastagsController = TextEditingController();
  Widget selectImage() {
    return Container(
      margin: EdgeInsets.only(
        left: defaultMarginApps,
        right: defaultMarginApps,
        bottom: 17,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Image(s)',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _image(),
        ],
      ),
    );
  }

  Widget captions() {
    return Container(
      margin: EdgeInsets.only(
        left: defaultMarginApps,
        right: defaultMarginApps,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add caption',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 84,
            child: TextField(
              controller: captionsController,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 26,
            left: defaultMarginApps,
            right: defaultMarginApps,
            bottom: 34,
          ),
          child: HeaderPageWidget(
            title: 'Post',
            pop: () {},
          ),
        ),
        selectImage(),
        captions(),
        Container(
          margin: EdgeInsets.only(
            left: defaultMarginApps,
            right: defaultMarginApps,
          ),
          child: CustomTextField(
            title: 'Add hastags',
            controller: hastagsController,
          ),
        ),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, postState) {
            if (postState is PostLoadingState) {
              return Container(
                margin: EdgeInsets.only(
                  left: defaultMarginApps,
                  right: defaultMarginApps,
                ),
                child: const LoadingButton(),
              );
            }
            return Container(
              margin: EdgeInsets.only(
                left: defaultMarginApps,
                right: defaultMarginApps,
              ),
              child: MainButton(
                title: 'Upload',
                onPressed: () async {
                  if (_croppedFile != null) {
                    final path = _croppedFile!.path;
                    post = PostData(
                      idUser: widget.idUser,
                      description: captionsController.text,
                      hastag: hastagsController.text,
                      datePublished: DateTime.now(),
                      likes: [],
                      postImage: File(path),
                    );
                    context.read<PostBloc>().add(AddPostEvent(post));
                    _croppedFile = null;
                    captionsController.text = '';
                    hastagsController.text = '';
                    post = PostData();
                    setState(() {});
                  } else {
                    Flushbar(
                      duration: const Duration(milliseconds: 1500),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: blackColor,
                      messageColor: whiteColor,
                      message: 'Please add photos first',
                    ).show(context);
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
