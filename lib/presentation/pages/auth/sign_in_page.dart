part of 'auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/arrow_back.png',
          width: 10,
        ),
        const SizedBox(
          height: 44,
        ),
        const SignInSignUpHeader(
          title: 'Sign In',
          subtitle: 'Enter your credentials',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: 'Email Address',
                isPassword: false,
                controller: emailController,
              ),
              CustomTextField(
                title: 'Password',
                isPassword: true,
                controller: passwordController,
              ),
              const Spacer(),
              BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
                listener: (context, state) {
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
                builder: (context, state) {
                  if (state is FirebaseAuthLoadingState) {
                    return const LoadingButton();
                  }
                  return MainButton(
                    title: 'Done',
                    onPressed: () {
                      SignInData data = SignInData(
                          email: emailController.text,
                          password: passwordController.text);
                      context
                          .read<FirebaseAuthBloc>()
                          .add(FirebaseAuthSignInEvent(data));
                    },
                  );
                },
              ),
              const SizedBox(
                height: 37,
              ),
              SignInSignUpFooter(
                onTap: () {
                  context
                      .read<PageBloc>()
                      .add(GoToSignUpPersonalPage(RegistrationData()));
                },
                title: 'Do not have an Account?',
                subtitle: 'Sign up',
                subtitleColor: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
