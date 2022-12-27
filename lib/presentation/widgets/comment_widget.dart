part of 'widgets.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1473&q=80'),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/love_red_icon.png',
                      width: 10,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '25',
                      style: blackTextFont.copyWith(
                        fontSize: 11,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kamcy el',
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra aliquam, congue habitasse tortor. Fringilla nunc aliquam volutpat suscipit porttitor in quis sagittis hac. Tellus sed ac libero',
                    style: blackTextFont.copyWith(
                      fontSize: 8,
                      fontWeight: bold,
                    ),
                    maxLines: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          '2hrs Ago',
          style: blackTextFont.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
        ),
      ],
    );
  }
}
