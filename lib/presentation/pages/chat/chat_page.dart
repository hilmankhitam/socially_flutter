part of 'chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();

  Widget searchView() {
    return Container(
      padding: EdgeInsets.fromLTRB(defaultMarginApps, 17, defaultMarginApps, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: mainColor,
          ),
        ),
        height: 34,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search chat here.....',
            hintStyle: mainTextFont.copyWith(
              fontSize: 10,
              fontWeight: medium,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/search_icon.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget frequentlyChatted() {
    return SizedBox(
      height: 51,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            UserEntity myPersonalInfo = (userState as UserLoaded).user;
            return StreamBuilder<List<String>>(
                stream: di
                    .locator<GetUserInfoChatUseCase>()
                    .execute(myPersonalInfo.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> listUidUser = snapshot.data!;
                    context
                        .read<GetUserInfoChatBloc>()
                        .add(GetUserInfoByIdEvent(listUidUser));
                    return BlocBuilder<GetUserInfoChatBloc,
                        GetUserInfoChatState>(
                      builder: (context, getUserInfoChatState) {
                        if (getUserInfoChatState
                            is GetUserInfoChatSuccessState) {
                          List<UserEntity> users = getUserInfoChatState.users;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: listUidUser.length,
                            itemBuilder: ((context, index) {
                              UserEntity user = users[index];
                              return GestureDetector(
                                onTap: () => context
                                    .read<PageBloc>()
                                    .add(GoToDetailChatPage(user)),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: (index == 0) ? defaultMarginApps : 0,
                                    right: (index == listUidUser.length - 1)
                                        ? defaultMarginApps
                                        : 13,
                                  ),
                                  width: 52,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 49,
                                        height: 49,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: (user.profilePicture == '')
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                    'assets/user_pic.png',
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image: NetworkImage(
                                                    user.profilePicture!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image.asset(
                                          (user.isOnline!)
                                              ? 'assets/online_icon.png'
                                              : 'assets/offline_icon.png',
                                          width: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                });
          },
        ),
      ),
    );
  }

  Widget listChat() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          UserEntity myPersonalInfo = (userState as UserLoaded).user;
          return StreamBuilder<List<String>>(
              stream: di
                  .locator<GetUserInfoChatUseCase>()
                  .execute(myPersonalInfo.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> listUidUser = snapshot.data!;

                  return BlocBuilder<GetUserInfoChatBloc, GetUserInfoChatState>(
                    builder: (context, getUserInfoChatState) {
                      if (getUserInfoChatState is GetUserInfoChatSuccessState) {
                        List<UserEntity> users = getUserInfoChatState.users;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listUidUser.length,
                          itemBuilder: (context, index) {
                            UserEntity user = users[index];
                            return Container(
                              margin: EdgeInsets.only(
                                top: (index == 0) ? 16 : 0,
                                bottom:
                                    (index == listUidUser.length - 1) ? 70 : 21,
                              ),
                              child: ChatTile(
                                user: user,
                                onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(GoToDetailChatPage(user));
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding:
              EdgeInsets.fromLTRB(defaultMarginApps, 26, defaultMarginApps, 0),
          child: HeaderPageWidget(
            title: 'Chats',
            pop: () {},
          ),
        ),
        searchView(),
        Container(
          padding:
              EdgeInsets.fromLTRB(defaultMarginApps, 16, defaultMarginApps, 10),
          child: Text(
            'Frequently chatted',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        ),
        frequentlyChatted(),
        Container(
          padding:
              EdgeInsets.fromLTRB(defaultMarginApps, 16, defaultMarginApps, 0),
          child: Text(
            'All Messages',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        ),
        listChat(),
      ],
    );
  }
}
