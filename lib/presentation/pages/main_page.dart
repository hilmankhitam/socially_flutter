part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  const MainPage({this.bottomNavBarIndex = 0, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  Widget customBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 69,
        child: BottomNavigationBar(
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          elevation: 0,
          currentIndex: bottomNavBarIndex,
          onTap: (index) {
            setState(() {
              bottomNavBarIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 25,
                child: Image.asset((bottomNavBarIndex == 0)
                    ? 'assets/home_icon_green.png'
                    : 'assets/home_icon.png'),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 25,
                child: Image.asset((bottomNavBarIndex == 1)
                    ? 'assets/social_icon_green.png'
                    : 'assets/social_icon.png'),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 25,
                child: Image.asset((bottomNavBarIndex == 2)
                    ? 'assets/upload_icon_green.png'
                    : 'assets/upload_icon.png'),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 25,
                child: Image.asset((bottomNavBarIndex == 3)
                    ? 'assets/chat_icon_green.png'
                    : 'assets/chat_icon.png'),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 25,
                child: Image.asset((bottomNavBarIndex == 4)
                    ? 'assets/profile_icon_green.png'
                    : 'assets/profile_icon.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                });
              },
              children: [
                BlocBuilder<PostPageBloc, PostPageState>(
                  builder: (context, pageState) {
                    return (pageState is OnNotificationPage)
                        ? const NotificationPage()
                        : (pageState is OnCommentPage)
                            ? const CommentPage()
                            : (pageState is OnSearchPage)
                                ? const SearchPage()
                                : const PostPage();
                  },
                ),
                const SocialPage(),
                const UploadPage(),
                const ChatPage(),
                const ProfilePage(),
              ],
            ),
            customBottomNavBar(),
          ],
        ),
      ),
    );
  }
}
