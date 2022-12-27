part of 'widgets.dart';

class SignInSignUpHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const SignInSignUpHeader({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextFont.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: blackTextFont.copyWith(fontSize: 16, fontWeight: medium),
        ),
      ],
    );
  }
}
