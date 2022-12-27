part of 'pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    if (!mounted) {
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);
    Timer(const Duration(seconds: 2), () {
      if (firebaseUser == null) {
        if (prevPageEvent is! GoToSignInPage) {
          prevPageEvent = GoToSignInPage();
          context.read<PageBloc>().add(prevPageEvent!);
        }
      } else {
        if (prevPageEvent is! GoToMainPage) {
          prevPageEvent = const GoToMainPage(0);

          _scaffoldKey.currentContext?.read<PageBloc>().add(prevPageEvent!);
        }
      }
      _scaffoldKey.currentContext?.read<PageBloc>().add(GoToSignInPage());
    });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 160,
                ),
              ),
              Positioned(
                top: size.height / 6.5,
                right: size.width / 5,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
              Positioned(
                top: size.height / 4,
                left: size.width / 8,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
              Positioned(
                top: size.height / 3.2,
                right: size.width / 8,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
              Positioned(
                bottom: size.height / 2.6,
                left: size.width / 2.5,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
              Positioned(
                bottom: size.height / 2.75,
                right: size.width / 12,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
              Positioned(
                bottom: size.height / 3.1,
                left: size.width / 10,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
              Positioned(
                bottom: size.height / 5.2,
                right: size.width / 4,
                child: Image.asset(
                  'assets/faceicon.png',
                  width: 17.31,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
