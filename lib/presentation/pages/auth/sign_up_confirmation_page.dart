part of 'auth.dart';

class SignUpConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;
  const SignUpConfirmationPage(this.registrationData, {super.key});

  @override
  State<SignUpConfirmationPage> createState() => _SignUpConfirmationPageState();
}

class _SignUpConfirmationPageState extends State<SignUpConfirmationPage> {
  CroppedFile? _croppedFile;

  Future<void> getAndCropImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 30,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
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
      widget.registrationData.profileImage = File(path);
      return GestureDetector(
        onTap: () => getAndCropImage(),
        child: Container(
          height: 183,
          width: 183,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: greyColor,
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
          height: 183,
          width: 183,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: greyColor,
            image: DecorationImage(
              image: AssetImage('assets/user_pic.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<XFile?> getImage() async {
    //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   return image;
    // }

    // Future<XFile?> getImage(ImageSource source) async {
    //   final pickedFile =
    //       await _picker.pickImage(source: source, imageQuality: 50);
    //   CroppedFile? selectedFile;
    //   if (pickedFile == null) {
    //     var file = await ImageCropper.platform.cropImage(
    //         sourcePath: pickedFile!.path,
    //         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    //     selectedFile = file;
    //   }
    //   return XFile(selectedFile!.path);
    // }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context
              .read<PageBloc>()
              .add(GoToSignUpUsernamePage(widget.registrationData));
          return false;
        },
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            padding: const EdgeInsets.only(
              top: 123,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _image(),
                  const SizedBox(
                    height: 29,
                  ),
                  Text(
                    'Welcome',
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.registrationData.name,
                    style: blackTextFont.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
                    builder: (BuildContext context, state) {
                      if (state is FirebaseAuthLoadingState) {
                        return const LoadingButton();
                      }
                      return MainButton(
                        title: 'Continue',
                        onPressed: () {
                          photoProfileToUpload =
                              widget.registrationData.profileImage;
                          context.read<FirebaseAuthBloc>().add(
                              FirebaseAuthSignUpEvent(widget.registrationData));
                        },
                      );
                    },
                    listener: (BuildContext context, state) {
                      if (state is FirebaseAuthFailureState) {
                        Flushbar(
                          duration: const Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: blackColor,
                          messageColor: whiteColor,
                          message: state.message,
                        ).show(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
