part of 'widgets.dart';

class ChatTile extends StatelessWidget {
  final Function onTap;
  const ChatTile({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amina Mark',
                    style: blackTextFont.copyWith(
                      fontSize: 12,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'ekamcy@gmail.com',
                    style: mainTextFont.copyWith(
                      fontSize: 10,
                      fontWeight: reguler,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '08:43',
                style: blackTextFont.copyWith(
                  color: const Color(0xFFB3B9C9),
                  fontSize: 10,
                  fontWeight: reguler,
                ),
              ),
              Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor,
                ),
                child: Center(
                  child: Text(
                    '1',
                    style: whiteTextFont.copyWith(
                      fontSize: 8,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
