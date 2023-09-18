import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Message {
  bool isExpert;
  String message;
  String name;
  RxList<Reply> replies;

  Message(this.isExpert, this.message, this.name, this.replies);
}

class Reply {
  int likes;
  String message;
  String sender;

  Reply(this.likes, this.message, this.sender);
}
