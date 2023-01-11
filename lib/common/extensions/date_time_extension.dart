part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String readTimeStamp(int timeStamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds > 0 && diff.inSeconds < 60) {
      if (diff.inSeconds == 1) {
        time = '${diff.inSeconds} second ago';
      } else {
        time = '${diff.inSeconds} seconds ago';
      }
    } else if (diff.inMinutes > 0 && diff.inMinutes < 60) {
      if (diff.inSeconds == 1) {
        time = '${diff.inMinutes} minute ago';
      } else {
        time = '${diff.inMinutes} minutes ago';
      }
    } else if (diff.inHours > 0 && diff.inHours < 24) {
      if (diff.inHours == 1) {
        time = '${diff.inHours} hour ago';
      } else {
        time = '${diff.inHours} hours ago';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} Day ago';
      } else {
        time = '${diff.inDays} Days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} Week ago';
      } else {
        time = '${(diff.inDays / 7).floor()} Weeks ago';
      }
    }
    return time;
  }

  String readTimeStampChat(int timeStamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inDays < 1) {
      time = DateFormat.Hm().format(date);
    } else {
      time = DateFormat('dd/MM/yy').format(date);
    }
    return time;
  }
}
