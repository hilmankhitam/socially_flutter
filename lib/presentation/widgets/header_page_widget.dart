part of 'widgets.dart';

class HeaderPageWidget extends StatelessWidget {
  final String title;
  final Function pop;
  const HeaderPageWidget({required this.title, required this.pop, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => pop(),
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
          title,
          style: blackTextFont.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
