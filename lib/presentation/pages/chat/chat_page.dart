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

  List<String> listStories = [
    'Hai',
    'Nama',
    'Saya',
    'Hilman',
    'Khitam',
    'Khitam',
    'Khitam',
    'Khitam',
    'Khitam',
  ];

  Widget listStoryCard() {
    return SizedBox(
      height: 135,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: defaultMarginApps),
                child: const StoryCard()),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: listStories.length,
              itemBuilder: ((context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: (index == 0) ? 14 : 0,
                    right: (index == listStories.length - 1)
                        ? defaultMarginApps
                        : 14,
                  ),
                  child: const StoryCard(
                    isAnyContent: true,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget frequentlyChatted() {
    return SizedBox(
      height: 51,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: listStories.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.only(
                left: (index == 0) ? defaultMarginApps : 0,
                right:
                    (index == listStories.length - 1) ? defaultMarginApps : 13,
              ),
              width: 52,
              child: Stack(
                children: [
                  Container(
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/online_icon.png',
                      width: 12,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

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

  Widget listChat() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listStories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: (index == 0) ? 16 : 0,
              bottom: (index == listStories.length - 1) ? 70 : 21,
            ),
            child: ChatTile(
              onTap: () {
                context.read<PageBloc>().add(GoToDetailChatPage());
              },
            ),
          );
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
