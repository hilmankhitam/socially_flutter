part of 'auth.dart';

class SignUpUsernamePage extends StatefulWidget {
  final RegistrationData registrationData;
  const SignUpUsernamePage(this.registrationData, {super.key});

  @override
  State<SignUpUsernamePage> createState() => _SignUpUsernamePageState();
}

class _SignUpUsernamePageState extends State<SignUpUsernamePage> {
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.registrationData.username;
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => context
              .read<PageBloc>()
              .add(GoToSignUpPersonalPage(widget.registrationData)),
          child: Container(
            width: 10,
            height: 18.24,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/arrow_back.png'),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 44,
        ),
        const SignInSignUpHeader(
          title: 'Select a Username',
          subtitle: 'Help secure your account',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToSignUpPersonalPage(widget.registrationData));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                CustomTextField(
                  title: 'Username',
                  controller: usernameController,
                ),
                CustomTextField(
                  title: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                CustomTextField(
                  title: 'Confirm Password',
                  isPassword: true,
                  controller: confirmPasswordController,
                ),
                const Spacer(),
                MainButton(
                  title: 'Done',
                  onPressed: () {
                    if (!(usernameController.text != '' &&
                        passwordController.text != '' &&
                        confirmPasswordController.text != '')) {
                      Flushbar(
                        duration: const Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: blackColor,
                        messageColor: whiteColor,
                        message: 'Please fill all the fields',
                      ).show(context);
                    } else if (passwordController.text.length < 6) {
                      Flushbar(
                        duration: const Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: blackColor,
                        messageColor: whiteColor,
                        message: "Password's length min 6 characters",
                      ).show(context);
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      Flushbar(
                        duration: const Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: blackColor,
                        messageColor: whiteColor,
                        message: 'Mismatch password and confirmed password',
                      ).show(context);
                    } else {
                      widget.registrationData.username =
                          usernameController.text;
                      widget.registrationData.password =
                          passwordController.text;

                      context.read<PageBloc>().add(
                          GoToSignUpConfirmationPage(widget.registrationData));
                    }
                  },
                ),
                const SizedBox(
                  height: 37,
                ),
                SignInSignUpFooter(
                  title: 'Already have an account?',
                  subtitle: 'Sign In',
                  onTap: () {
                    context.read<PageBloc>().add(GoToSignInPage());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
