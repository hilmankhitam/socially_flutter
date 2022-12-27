part of 'widgets.dart';

class PostCard extends StatelessWidget {
  final Function onTap;
  final bool isCommentPage;
  const PostCard({required this.onTap, this.isCommentPage = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
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
                      'El kamcy speaks',
                      style: blackTextFont.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '1hr ago',
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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ',
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
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1499346030926-9a72daac6c63?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
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
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1551929175-f82f676827b8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1536588086516-cf8b058a7aa0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1473&q=80'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/love_icon.png',
                          width: 13,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '427',
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
                          '78',
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
            Text(
              'Liked by Annabel and 100+ others',
              style: blackTextFont.copyWith(
                fontSize: 10,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            isCommentPage
                ? const SizedBox()
                : Text(
                    'View all 78 comments',
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
