part of 'widgets.dart';

class InfoProfile extends StatelessWidget {
  final UserEntity user;
  final List<PostEntity> posts;
  final bool isUser;
  const InfoProfile(
      {required this.user,
      required this.posts,
      required this.isUser,
      super.key});

  @override
  Widget build(BuildContext context) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isUser
                    ? BlocBuilder<UserBloc, UserState>(
                        builder: (context, userState) {
                          if (userState is UserLoaded) {
                            if (photoProfileToUpload != null) {
                              uploadProfileImage(photoProfileToUpload!)
                                  .then((downloadUrl) {
                                photoProfileToUpload = null;
                                context.read<UserBloc>().add(
                                    UpdateUser(profilePicture: downloadUrl));
                              });
                            }
                            return SizedBox(
                              width: 67,
                              height: 67,
                              child: (userState.user.profilePicture == '')
                                  ? const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/user_pic.png'),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          userState.user.profilePicture!),
                                    ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    : SizedBox(
                        width: 67,
                        height: 67,
                        child: (user.profilePicture == '')
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/user_pic.png'),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.profilePicture!),
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
            GestureDetector(
              onTap: () {
                // change user to offline
                context.read<UserBloc>().add(
                      UpdateUser(
                        isOnline: false,
                        lastSeen: DateTime.now(),
                      ),
                    );
                //sign out firebase
                context
                    .read<FirebaseAuthBloc>()
                    .add(FirebaseAuthSignOutEvent());
                //change postpagebloc to initial
                context.read<PostPageBloc>().add(GoToPostPageInitial());
                //change profilepagebloc to initial
                context.read<ProfilePageBloc>().add(GoToProfilePageInitial());
                //change searchbloc to initial
                context.read<SearchBloc>().add(SearchEventInitial());
              },
              child: Image.asset(
                'assets/setting_icon.png',
                width: 20,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            user.about!,
            style: blackTextFont.copyWith(
              fontSize: 12,
              fontWeight: medium,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 42,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {},
            child: Text(
              'Edit Profile',
              style: whiteTextFont.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          children: [
            buildStatColumn(posts.length, 'Posts'),
            line(),
            buildStatColumn(user.following!.length, 'Following'),
            line(),
            buildStatColumn(user.follower!.length, 'Followers'),
          ],
        ),
      ],
    );
  }
}
