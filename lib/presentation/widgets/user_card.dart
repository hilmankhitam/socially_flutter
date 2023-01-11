part of 'widgets.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: user.profilePicture == ''
                ? const CircleAvatar(
                    backgroundImage: AssetImage('assets/user_pic.png'),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePicture!),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username!,
                style: blackTextFont.copyWith(
                  fontSize: 11,
                  fontWeight: bold,
                ),
              ),
              Text(
                user.name!,
                style: blackTextFont.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
