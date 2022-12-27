part of 'post.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<NotificationEntity> listNotification = [
      NotificationEntity(
        id: '123',
        dateTime: DateTime(2022, 12, 23, 10, 33),
        notificationType: 3,
        user: UserEntity(
          'iasd',
          'hilman@gmail.com',
          name: 'Akari',
          about: 'about',
          dateOfBirth: DateTime.now(),
          gender: 'Male',
          follower: const [],
          following: const [],
          profilePicture: 'https://picsum.photos/200/300/?blur',
          username: 'khitam__',
        ),
      ),
      NotificationEntity(
        id: '123',
        dateTime: DateTime(2022, 12, 23, 10, 36),
        notificationType: 1,
        user: UserEntity(
          'iasd',
          'hilman@gmail.com',
          name: 'Kito',
          about: 'about',
          dateOfBirth: DateTime.now(),
          gender: 'Male',
          follower: const [],
          following: const [],
          profilePicture: 'https://picsum.photos/200/300/?blur',
          username: 'khitam__',
        ),
      ),
      NotificationEntity(
        id: '123',
        dateTime: DateTime(2022, 12, 22, 12, 30),
        notificationType: 1,
        user: UserEntity(
          'iasd',
          'hilman@gmail.com',
          name: 'Hilman',
          about: 'about',
          dateOfBirth: DateTime.now(),
          gender: 'Male',
          follower: const [],
          following: const [],
          profilePicture: 'https://picsum.photos/200/300/?blur',
          username: 'Hilmankh__',
        ),
      ),
      NotificationEntity(
        id: '123',
        dateTime: DateTime(2022, 12, 22, 13, 45),
        notificationType: 2,
        user: UserEntity(
          'iasd',
          'hilman@gmail.com',
          name: 'Khitam',
          about: 'about',
          dateOfBirth: DateTime.now(),
          gender: 'Male',
          follower: const [],
          following: const [],
          profilePicture: 'https://picsum.photos/200/300/?blur',
          username: 'khitam__',
        ),
      ),
    ];
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<PostPageBloc>().add(GoToPostPage());
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
            'Notifications',
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/delete_icon.png'),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(defaultMarginApps, 27, defaultMarginApps, 70),
      children: [
        header(),
        NotificationWidget(listNotification: listNotification),
      ],
    );
  }
}
