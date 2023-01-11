part of 'post.dart';

class PostPage extends StatefulWidget {
  final List<String> following;
  const PostPage({required this.following, super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    // context.read<PostBloc>().add(GetAllPostsBasedOnFollowing(widget.following));
  }

  Widget searchView() {
    return Container(
      margin: EdgeInsets.fromLTRB(defaultMarginApps, 29, defaultMarginApps, 23),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                List<PostPageEvent> pop = [];
                pop.add(GoToPostPage(widget.following));
                context.read<PostPageBloc>().add(GoToSearchPage(pop));
              },
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
              child: const StoryCard(),
            ),
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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<PostBloc, PostState>(
          builder: (context, postState) {
            if (postState is GetPostsBasedFollowingSuccessState) {
              List<PostEntity> posts = postState.posts;
              List<UserEntity> users = postState.users;
              List<List<CommentEntity>> comments = postState.comments;
              List<List<UserEntity>> likes = postState.likes;
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: defaultMarginApps, vertical: 11),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    UserEntity user = users[index];
                    PostEntity post = posts[index];
                    List<CommentEntity> listComments = comments[index];
                    List<UserEntity> listLikes = likes[index];

                    return Container(
                      margin: EdgeInsets.only(
                        top: (index == 0) ? 11 : 14,
                        bottom: (index == posts.length - 1) ? 70 : 0,
                      ),
                      child: PostCard(
                        myPersonalId: (userState as UserLoaded).user.id!,
                        post: post,
                        user: user,
                        likes: listLikes,
                        comments: listComments,
                        onTap: () {
                          List<PostPageEvent> pop = [];
                          pop.add(GoToPostPage(widget.following));
                          context.read<PostPageBloc>().add(GoToCommentPostPage(
                                post.idPost!,
                                pop,
                              ));
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
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
