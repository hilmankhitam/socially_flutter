part of 'post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void dispose() {
    super.dispose();
  }

  Widget searchView() {
    return Container(
      margin: EdgeInsets.fromLTRB(defaultMarginApps, 29, defaultMarginApps, 23),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<PostPageBloc>().add(GoToSearchPage()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: mainColor,
                  ),
                ),
                height: 34,
                child: Row(
                  children: [
                    Image.asset('assets/search_icon.png'),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      'Type something...........',
                      style: mainTextFont.copyWith(
                        fontSize: 10,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () =>
                context.read<PostPageBloc>().add(GoToNotificationPage()),
            child: Image.asset(
              'assets/notification_icon.png',
              width: 18,
            ),
          ),
        ],
      ),
    );
  }

  List<String> listStories = [
    'Hai',
    'Nama',
    'Saya',
    'Hilman',
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

  Widget listPostCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMarginApps, vertical: 11),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listStories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: (index == 0) ? 11 : 14,
              bottom: (index == listStories.length - 1) ? 70 : 0,
            ),
            child: PostCard(
              onTap: () {
                context.read<PostPageBloc>().add(GoToCommentPage());
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
        searchView(),
        listStoryCard(),
        listPostCard(),
      ],
    );
  }
}
