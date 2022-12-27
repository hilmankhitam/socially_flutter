part of 'widgets.dart';

class SignInSignUpFooter extends StatelessWidget {
  final Function onTap;
  final String title;
  final Color titleColor;
  final String subtitle;
  final Color subtitleColor;
  const SignInSignUpFooter(
      {required this.title,
      this.titleColor = blackColor,
      required this.subtitle,
      this.subtitleColor = blackColor,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: blackTextFont.copyWith(fontWeight: medium, color: titleColor),
        ),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
          onTap: () => onTap(),
          child: Text(
            subtitle,
            style: mainTextFont.copyWith(
              fontWeight: bold,
              color: subtitleColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
