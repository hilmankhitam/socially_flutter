part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);

    if (firebaseUser == null) {
      if (prevPageEvent is! GoToSignInPage) {
        prevPageEvent = GoToSignInPage();
        context.read<PageBloc>().add(prevPageEvent!);
      }
    } else {
      if (prevPageEvent is! GoToMainPage) {
        prevPageEvent = const GoToMainPage(0);

        context.read<PageBloc>().add(prevPageEvent!);
      }
    }
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, pageState) => (pageState is OnSignInPage)
          ? const SignInPage()
          : (pageState is OnSignUpPersonalPage)
              ? SignUpPersonalPage(pageState.registrationData)
              : (pageState is OnSignUpUsernamePage)
                  ? SignUpUsernamePage(pageState.registrationData)
                  : (pageState is OnSignUpConfirmationPage)
                      ? SignUpConfirmationPage(pageState.registrationData)
                      : (pageState is OnMainPage)
                          ? MainPage(
                              bottomNavBarIndex: pageState.bottomNavBarIndex,
                            )
                          : (pageState is OnDetailChatPage)
                              ? const DetailChatPage()
                              : Container(),
    );
  }
}
