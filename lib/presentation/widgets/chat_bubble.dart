part of 'widgets.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  const ChatBubble({required this.text, this.isSender = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 19,
      ),
      child: Column(
        // crossAxisAlignment:
        //     isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 206,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isSender ? 20 : 0),
                      bottomRight: Radius.circular(isSender ? 0 : 20),
                    ),
                    color: isSender ? greyColor : mainColor,
                  ),
                  child: Text(
                    text,
                    style: blackTextFont.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                      color: isSender ? blackColor : whiteColor,
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
