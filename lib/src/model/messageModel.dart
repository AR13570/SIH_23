import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Message {
  String messageId;
  bool isExpert;
  String message;
  String name;
  RxList<Reply> replies;

  Message(
      {required this.messageId,
      required this.isExpert,
      required this.message,
      required this.name,
      required this.replies});
}

class Reply {
  String replyId;
  int likes;
  String message;
  String sender;

  Reply(
      {required this.replyId,
      required this.likes,
      required this.message,
      required this.sender});
}
