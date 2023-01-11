part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  const MainPage({this.bottomNavBarIndex = 0, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int bottomNavBarIndex = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //online
      context.read<UserBloc>().add(
            const UpdateUser(
              isOnline: true,
            ),
          );
      debugPrint(state.toString());
    } else {
      //offline
      context.read<UserBloc>().add(
            UpdateUser(
              isOnline: false,
              lastSeen: DateTime.now(),
            ),
          );
      debugPrint(state.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
            BlocConsumer<UserBloc, UserState>(
              listener: (context, userState) {
                if (userState is UserLoaded) {
                  context.read<PostBloc>().add(GetAllPostsBasedOnFollowing(
                      userState.user.following!, userState.user.id!));
                }
              },
              builder: (context, userState) {
                if (userState is UserLoaded) {
                  return PageView(
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
                              : (pageState is OnCommentPostPage)
                                  ? CommentPage(
                                      idPost: pageState.idPost,
                                      postPagePop: pageState.pop,
                                      profilePagePop: const [],
                                    )
                                  : (pageState is OnSearchPage)
                                      ? SearchPage(
                                          pop: pageState.pop,
                                        )
                                      : (pageState is OnDetailProfilePage)
                                          ? DetailProfilePage(
                                              pop: pageState.pop,
                                              uid: pageState.uid,
                                            )
                                          : (pageState is OnProfilePostPage)
                                              ? ProfilePage(pop: pageState.pop)
                                              : PostPage(
                                                  following:
                                                      userState.user.following!,
                                                );
                        },
                      ),
                      const SocialPage(),
                      UploadPage(
                        idUser: userState.user.id!,
                      ),
                      const ChatPage(),
                      BlocBuilder<ProfilePageBloc, ProfilePageState>(
                        builder: (context, pageState) {
                          return (pageState is OnProfileProfilePage)
                              ? const ProfilePage(
                                  pop: [],
                                )
                              : (pageState is OnCommentProfilePage)
                                  ? CommentPage(
                                      idPost: pageState.idPost,
                                      profilePagePop: pageState.pop,
                                      postPagePop: const [],
                                    )
                                  : const ProfilePage(pop: []);
                        },
                      ),
                    ],
                  );
                } else {
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        bottomNavBarIndex = index;
                      });
                    },
                    children: const [
                      CircularProgressIndicator(),
                      CircularProgressIndicator(),
                      CircularProgressIndicator(),
                      CircularProgressIndicator(),
                      CircularProgressIndicator(),
                    ],
                  );
                }
              },
            ),
            customBottomNavBar(),
          ],
        ),
      ),
    );
  }
}
