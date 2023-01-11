part of 'widgets.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const MainButton({required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 27),
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: whiteTextFont.copyWith(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
