part of 'widgets.dart';

class ChatBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isSender;
  const ChatBubble({required this.message, this.isSender = false, super.key});

  @override
  Widget build(BuildContext context) {
    Widget image() {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: const BoxConstraints(
          maxHeight: 225,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(message.chatImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 19,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
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
                child: Column(
                  crossAxisAlignment: isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    message.chatImage.isNotEmpty ? image() : const SizedBox(),
                    Text(
                      message.message,
                      style: blackTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                        color: isSender ? blackColor : whiteColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat.Hm().format(message.createdAt),
                          style: blackTextFont.copyWith(
                            fontSize: 10,
                            fontWeight: medium,
                            color: isSender ? blackColor : whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
