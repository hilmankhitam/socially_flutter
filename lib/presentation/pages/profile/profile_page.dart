import 'package:flutter/material.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/presentation/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  final bool isUser;
  const ProfilePage({this.isUser = false, super.key});

  @override
  Widget build(BuildContext context) {
    Widget infoProfile() {
      return Container(
        margin: EdgeInsets.only(
            top: 36,
            bottom: 17,
            left: defaultMarginApps,
            right: defaultMarginApps),
        child: InfoProfile(
          isUser: isUser,
        ),
      );
    }

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
      'Khitam',
      'Khitam',
    ];

    Widget listPost() {
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
              itemCount: listStories.length,
              itemBuilder: (context, index) {
                return Container(
                  // width: MediaQuery.of(context).size.width -
                  //     (defaultMarginApps * 2) -
                  //     (10 * 2) / 3,
                  height: MediaQuery.of(context).size.width -
                      (defaultMarginApps * 2) -
                      (10 * 2) / 3,
                  constraints:
                      const BoxConstraints(maxHeight: 99, maxWidth: 99),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1536588086516-cf8b058a7aa0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget listFollower() {
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
                itemCount: listStories.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMarginApps : 0,
                      right: (index == listStories.length - 1)
                          ? defaultMarginApps
                          : 26,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 54,
                          height: 54,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1536588086516-cf8b058a7aa0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Ayunda',
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

    return ListView(
      padding: const EdgeInsets.only(top: 28, bottom: 70),
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMarginApps),
          child: HeaderPageWidget(
            title: isUser ? 'My Profile' : 'Profile',
            pop: () {},
          ),
        ),
        infoProfile(),
        isUser ? const SizedBox() : listFollower(),
        listPost(),
      ],
    );
  }
}
