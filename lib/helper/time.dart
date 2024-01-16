import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String timeAgo(Timestamp d) {
  Duration diff = DateTime.now().difference(d.toDate());
  if (diff.inDays > 365) return DateFormat.yMMMd().format(d.toDate());
  if (diff.inDays > 30) return DateFormat.yMMMd().format(d.toDate());
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}
