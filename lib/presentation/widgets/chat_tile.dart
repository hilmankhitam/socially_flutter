part of 'widgets.dart';

class ChatTile extends StatefulWidget {
  final UserEntity user;
  final Function onTap;
  const ChatTile({required this.user, required this.onTap, super.key});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        UserEntity myPersonalInfo = (userState as UserLoaded).user;
        return GestureDetector(
          onTap: () => widget.onTap(),
          child: StreamBuilder<List<MessageEntity>>(
              stream: di
                  .locator<GetMessagesByIdUseCase>()
                  .execute(myPersonalInfo.id!, widget.user.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MessageEntity> messages = snapshot.data!;
                  messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                  var unreadMessages = messages
                      .where((message) =>
                          !message.read.contains(myPersonalInfo.id))
                      .length;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: widget.user.profilePicture == ''
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/user_pic.png'),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        widget.user.profilePicture!),
                                  ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.name!,
                                style: blackTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                              Text(
                                messages.last.message,
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
                            messages.last.createdAt.readTimeStampChat(
                                messages.last.createdAt.millisecondsSinceEpoch),
                            style: blackTextFont.copyWith(
                              color: const Color(0xFFB3B9C9),
                              fontSize: 10,
                              fontWeight: reguler,
                            ),
                          ),
                          unreadMessages == 0
                              ? const SizedBox()
                              : Container(
                                  width: 17,
                                  height: 17,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mainColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$unreadMessages',
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
                  );
                } else {
                  return const SizedBox();
                }
              }),
        );
      },
    );
  }
}
