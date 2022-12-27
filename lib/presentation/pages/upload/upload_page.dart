import 'package:flutter/material.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/presentation/widgets/widgets.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
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
          Container(
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
        Container(
          margin: EdgeInsets.only(
            left: defaultMarginApps,
            right: defaultMarginApps,
          ),
          child: SignInSignUpButton(
            title: 'Upload',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
