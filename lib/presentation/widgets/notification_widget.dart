part of 'widgets.dart';

class NotificationWidget extends StatefulWidget {
  final List<NotificationEntity> listNotification;
  const NotificationWidget({required this.listNotification, super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    Set seen = <DateTime>{};
    List<NotificationEntity> uniqueList = widget.listNotification
        .where((notification) => seen.add(notification.dateTime))
        .toList();
    // final ids = <DateTime>{};
    // listNotification.retainWhere((notication) => ids.add(notication.dateTime));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          'Today',
          style: blackTextFont.copyWith(
            fontWeight: medium,
            fontSize: 14,
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: uniqueList.length,
            itemBuilder: (context, index) {
              final NotificationEntity notification =
                  uniqueList[index];
              var dateFormat =
                  DateFormat('dd-MM-yyyy').format(notification.dateTime);
              var dateTime = Jiffy(dateFormat, 'dd-MM-yyyy').fromNow();
              return Container(
                margin: EdgeInsets.only(
                  top: index == 0 ? 12 : 0,
                  bottom: index == uniqueList.length - 1 ? 70 : 14,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 46,
                      height: 46,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(notification.user.profilePicture!),
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        notification.notificationType == 1
                            ? Row(
                                children: [
                                  Text(
                                    notification.user.name!,
                                    style: blackTextFont.copyWith(
                                      fontWeight: semiBold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Followed you',
                                    style: blackTextFont.copyWith(
                                      fontWeight: medium,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            : (notification.notificationType == 2)
                                ? Row(
                                    children: [
                                      Text(
                                        '${notification.user.name!} Liked your',
                                        style: blackTextFont.copyWith(
                                          fontWeight: semiBold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'photo',
                                        style: blackTextFont.copyWith(
                                          fontWeight: medium,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        '${notification.user.name!} commented on your',
                                        style: blackTextFont.copyWith(
                                          fontWeight: semiBold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'post',
                                        style: blackTextFont.copyWith(
                                          fontWeight: medium,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                        Text(
                          dateTime,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
