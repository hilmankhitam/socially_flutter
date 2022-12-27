part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final bool isPassword;
  final TextEditingController controller;
  const CustomTextField(
      {required this.title,
      this.isPassword = false,
      required this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(10)),
            height: 49,
            child: TextField(
              obscureText: isPassword,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
