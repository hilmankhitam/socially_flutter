part of 'widgets.dart';

class PostCard extends StatefulWidget {
  final String myPersonalId;
  final UserEntity user;
  final PostEntity post;
  final List<UserEntity> likes;
  final List<CommentEntity> comments;
  final Function onTap;
  final bool isCommentPage;
  const PostCard(
      {required this.myPersonalId,
      required this.user,
      required this.post,
      required this.likes,
      required this.comments,
      required this.onTap,
      this.isCommentPage = false,
      super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    bool isLike = (widget.post.likes.contains(widget.myPersonalId));

    var time = widget.post.datePublished.millisecondsSinceEpoch;

    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 19,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: greyColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.user.profilePicture!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name!,
                      style: blackTextFont.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      widget.post.datePublished.readTimeStamp(time),
                      style: blackTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              widget.post.description,
              style: blackTextFont.copyWith(
                fontSize: 10,
                fontWeight: reguler,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              widget.post.hastag,
              style: blackTextFont.copyWith(
                fontSize: 10,
                fontWeight: reguler,
              ),
            ),
            const SizedBox(
              height: 11,
            ),
            Container(
              height: 186,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.post.postImage),
                  fit: BoxFit.cover,
                ),
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 46,
                      child: Stack(
                        children: widget.likes
                            .asMap()
                            .map(
                              (index, user) => MapEntry(
                                index,
                                Align(
                                  alignment: (index == 0)
                                      ? Alignment.centerLeft
                                      : (index == 1)
                                          ? Alignment.center
                                          : Alignment.centerRight,
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: user.profilePicture == ''
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/user_pic.png'),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                user.profilePicture!),
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        isLike
                            ? GestureDetector(
                                onTap: () {
                                  context.read<LikeUnlikeBloc>().add(
                                      UnlikeThisPostEvent(widget.post.idPost!,
                                          widget.myPersonalId));
                                  widget.post.likes.remove(widget.myPersonalId);
                                  setState(() {});
                                },
                                child: Image.asset(
                                  'assets/love_icon.png',
                                  width: 13,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  context.read<LikeUnlikeBloc>().add(
                                      LikeThisPostEvent(widget.post.idPost!,
                                          widget.myPersonalId));
                                  widget.post.likes.add(widget.myPersonalId);
                                  setState(() {});
                                },
                                child: Image.asset(
                                  'assets/love_white_icon.png',
                                  width: 13,
                                ),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.post.likes.length.toString(),
                          style: blackTextFont.copyWith(
                            fontSize: 10,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/comment_icon.png',
                          width: 13,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.comments.length.toString(),
                          style: blackTextFont.copyWith(
                            fontSize: 10,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            widget.likes.isNotEmpty
                ? Text(
                    'Liked by ${widget.likes.first.name} and ${widget.post.likes.length - 1} others',
                    style: blackTextFont.copyWith(
                      fontSize: 10,
                      fontWeight: bold,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 3,
            ),
            widget.isCommentPage
                ? const SizedBox()
                : Text(
                    'View all ${widget.comments.length} comments',
                    style: blackTextFont.copyWith(
                      fontSize: 10,
                      fontWeight: bold,
                      color: blackColor.withOpacity(0.5),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
