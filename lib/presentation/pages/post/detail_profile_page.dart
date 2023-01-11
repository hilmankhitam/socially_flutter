part of 'post.dart';

class DetailProfilePage extends StatefulWidget {
  final List<PostPageEvent> pop;
  final String uid;
  const DetailProfilePage({required this.pop, required this.uid, super.key});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  int follower = 0;
  int following = 0;
  List<PostEntity> posts = [];
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    context.read<DetailProfileUserBloc>().add(FetchDetailProfile(widget.uid));
  }

  Expanded buildStatColumn(int num, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            num.toString(),
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
          Text(
            label,
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }

  Image line() {
    return Image.asset(
      'assets/line.png',
      height: 46,
    );
  }

  // HEADER
  Widget header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<PostPageBloc>().add(widget.pop.last);
              widget.pop.remove(widget.pop.last);
            },
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
          Text(
            'Profile',
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  // Info Profile
  Widget infoProfile(UserEntity user, String myPersonalId) {
    return Container(
      margin: EdgeInsets.only(
          top: 36,
          bottom: 17,
          left: defaultMarginApps,
          right: defaultMarginApps),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 67,
                    height: 67,
                    child: (user.profilePicture == '')
                        ? const CircleAvatar(
                            backgroundImage: AssetImage('assets/user_pic.png'),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePicture!),
                          ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name!,
                        style: blackTextFont.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        'Bauchi, Bauchi',
                        style: blackTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.more_vert,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  user.about!,
                  style: blackTextFont.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<PageBloc>().add(GoToDetailChatPage(user));
                    },
                    child: Container(
                      width: 45,
                      height: 31,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15.5),
                      ),
                      child: Image.asset(
                        'assets/chat_icon.png',
                        width: 16,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  isFollowing
                      ? GestureDetector(
                          onTap: () async {
                            setState(() {
                              isFollowing = false;
                              follower--;
                            });
                            context
                                .read<FollowUnfollowBloc>()
                                .add(UnfollowUserEvent(
                                  myPersonalId: myPersonalId,
                                  followingUserId: widget.uid,
                                ));
                          },
                          child: Container(
                            width: 90,
                            height: 31,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.5),
                              color: whiteColor,
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Unfollow',
                                style: blackTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            setState(() {
                              isFollowing = true;
                              follower++;
                            });
                            context
                                .read<FollowUnfollowBloc>()
                                .add(FollowUserEvent(
                                  myPersonalId: myPersonalId,
                                  followingUserId: widget.uid,
                                ));
                          },
                          child: Container(
                            width: 90,
                            height: 31,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.5),
                              color: mainColor,
                            ),
                            child: Center(
                              child: Text(
                                'Follow',
                                style: whiteTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              buildStatColumn(posts.length, 'Posts'),
              line(),
              buildStatColumn(following, 'Following'),
              line(),
              buildStatColumn(follower, 'Followers'),
            ],
          ),
        ],
      ),
    );
  }

  // listFollowers
  Widget listFollowers(List<UserEntity> followers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1.5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
          child: Text(
            'Followers',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: bold,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          height: 75,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: followers.length,
              itemBuilder: ((context, index) {
                final UserEntity follower = followers[index];
                return Container(
                  margin: EdgeInsets.only(
                    left: (index == 0) ? defaultMarginApps : 0,
                    right: (index == followers.length - 1)
                        ? defaultMarginApps
                        : 26,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 54,
                        height: 54,
                        child: (follower.profilePicture == '')
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/user_pic.png'),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(follower.profilePicture!),
                              ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        follower.name!,
                        style: blackTextFont.copyWith(
                          fontSize: 10,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Divider(
          thickness: 1.5,
        ),
      ],
    );
  }

  Widget listPosts(UserEntity user) {
    posts.sort((a, b) => b.datePublished.compareTo(a.datePublished));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Posts',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final PostEntity post = posts[index];
              return GestureDetector(
                onTap: () {
                  widget.pop.add(GoToDetailProfilePage(widget.uid, widget.pop));
                  context.read<PostPageBloc>().add(
                        GoToCommentPostPage(post.idPost!, widget.pop),
                      );
                },
                child: Container(
                  height: MediaQuery.of(context).size.width -
                      (defaultMarginApps * 2) -
                      (10 * 2) / 3,
                  constraints:
                      const BoxConstraints(maxHeight: 99, maxWidth: 99),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(post.postImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 28, bottom: 70),
      children: [
        header(),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            UserEntity myPersonalInfo = (userState as UserLoaded).user;
            return BlocConsumer<DetailProfileUserBloc, DetailProfileUserState>(
              listener: (context, detailProfileUserstate) {
                if (detailProfileUserstate is DetailProfileUserSuccess) {
                  final UserEntity user = detailProfileUserstate.user;
                  follower = user.follower!.length;
                  following = user.following!.length;
                  isFollowing = user.follower!.contains(myPersonalInfo.id);
                  posts = detailProfileUserstate.posts;
                }
              },
              builder: (context, detailProfileUserstate) {
                if (detailProfileUserstate is DetailProfileUserSuccess) {
                  final UserEntity user = detailProfileUserstate.user;
                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      infoProfile(user, myPersonalInfo.id!),
                      user.follower!.isEmpty
                          ? const SizedBox()
                          : listFollowers(detailProfileUserstate.followers),
                      listPosts(user),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
