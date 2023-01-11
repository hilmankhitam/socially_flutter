import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/presentation/bloc/page/post_page/post_page_bloc.dart';
import 'package:socially/presentation/bloc/page/profile_page/profile_page_bloc.dart';
import 'package:socially/presentation/bloc/user/user_bloc.dart';
import 'package:socially/presentation/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final List<PostPageEvent> pop;
  const ProfilePage({required this.pop, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> onRefresh(String uid) async {
    if (mounted) {
      context.read<UserBloc>().add(LoadUser(uid));
    }
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.pop.isNotEmpty
              ? GestureDetector(
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
                )
              : const SizedBox(),
          Text(
            'My Profile',
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

  Widget infoProfileUser(UserEntity user, List<PostEntity> posts) {
    return Container(
      margin: EdgeInsets.only(
          top: 36,
          bottom: 17,
          left: defaultMarginApps,
          right: defaultMarginApps),
      child: InfoProfile(
        posts: posts,
        user: user,
        isUser: true,
      ),
    );
  }

  Widget listPosts(UserEntity user, List<PostEntity> posts) {
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
                  List<ProfilePageEvent> pop = [];
                  pop.add(GoToProfileProfilePage());
                  context
                      .read<ProfilePageBloc>()
                      .add(GoToCommentProfilePage(post.idPost!, pop));
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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        UserEntity user = (userState as UserLoaded).user;
        List<PostEntity> posts = userState.posts;
        return RefreshIndicator(
          onRefresh: () => onRefresh(user.id!),
          child: ListView(
            padding: const EdgeInsets.only(top: 28, bottom: 70),
            children: [
              header(),
              infoProfileUser(user, posts),
              listPosts(user, posts),
            ],
          ),
        );
      },
    );
  }
}
