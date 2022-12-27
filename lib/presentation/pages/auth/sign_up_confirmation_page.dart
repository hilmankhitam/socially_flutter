part of 'auth.dart';

class SignUpConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;
  const SignUpConfirmationPage(this.registrationData, {super.key});

  @override
  State<SignUpConfirmationPage> createState() => _SignUpConfirmationPageState();
}

class _SignUpConfirmationPageState extends State<SignUpConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    Future<XFile?> getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image;
    }

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
                  GestureDetector(
                    onTap: () async {
                      final image = await getImage();
                      if (image != null) {
                        widget.registrationData.profileImage = File(image.path);
                      } else {
                        widget.registrationData.profileImage = null;
                      }

                      setState(() {});
                    },
                    child: Container(
                      height: 183,
                      width: 183,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor,
                        image: (widget.registrationData.profileImage == null)
                            ? const DecorationImage(
                                image: AssetImage('assets/user_pic.png'),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: FileImage(
                                    widget.registrationData.profileImage!),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Text(
                    'Welcome',
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 53,
                  ),
                  BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
                    builder: (BuildContext context, state) {
                      if (state is FirebaseAuthLoadingState) {
                        return const LoadingButton();
                      }
                      return SignInSignUpButton(
                        title: 'Continue',
                        onPressed: () {
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

// (state is FirebaseAuthInitial ||
                  //         state is FirebaseAuthSuccessState ||
                  //         state is FirebaseAuthFailureState)
                  //     ? SignInSignUpButton(
                  //         title: 'Continue',
                  //         onPressed: () async {
                  //           context.read<FirebaseAuthBloc>().add(
                  //               FirebaseAuthSignUpEvent(
                  //                   widget.registrationData));

                  //           if (state is FirebaseAuthFailureState) {
                  //             Future.delayed(const Duration(seconds: 0))
                  //                 .then((_) {
                  //               Flushbar(
                  //                 duration: const Duration(milliseconds: 1500),
                  //                 flushbarPosition: FlushbarPosition.TOP,
                  //                 backgroundColor: blackColor,
                  //                 messageColor: whiteColor,
                  //                 message: state.message,
                  //               ).show(context);
                  //             });
                  //           }
                  //         },
                  //       )
                  //     : const LoadingButton(),