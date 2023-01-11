part of 'widgets.dart';

class CommentWidget extends StatelessWidget {
  final CommentEntity comment;
  final UserEntity user;
  const CommentWidget({required this.comment, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    var time = comment.createdAt!.millisecondsSinceEpoch;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: (user.profilePicture == '')
                      ? const CircleAvatar(
                          backgroundImage: AssetImage('assets/user_pic.png'),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePicture!),
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Row(
                //   children: [
                //     Image.asset(
                //       'assets/love_red_icon.png',
                //       width: 10,
                //     ),
                //     const SizedBox(
                //       width: 3,
                //     ),
                //     Text(
                //       '25',
                //       style: blackTextFont.copyWith(
                //         fontSize: 11,
                //         fontWeight: medium,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name!,
                  style: blackTextFont.copyWith(
                    fontSize: 13,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      (defaultMarginApps * 2) -
                      95,
                  child: Text(
                    comment.comment!,
                    style: blackTextFont.copyWith(
                      fontSize: 10,
                      fontWeight: bold,
                    ),
                    maxLines: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
        Flexible(
          child: Text(
            comment.createdAt!.readTimeStamp(time),
            style: blackTextFont.copyWith(
              fontSize: 10,
              fontWeight: medium,
            ),
          ),
        ),
      ],
    );
  }
}
