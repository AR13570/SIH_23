import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/model/messageModel.dart';

import '../screen/bottom_navbar.dart';

class ReplyWidget extends StatelessWidget {
  Reply reply;
  late String messageId;
  bool selected;
  ReplyWidget(
      {super.key,
      required this.reply,
      required this.messageId,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 12,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 12,
          ),
          backgroundColor: Colors.grey,
        ),
        title: Text(
          reply.message,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          reply.sender,
        ),
        trailing: Chip(
          label: Text("${reply.likes.length}"),
          deleteIcon: Icon(
            !selected ? Icons.thumb_up : Icons.thumb_down,
            size: 17,
          ),
          onDeleted: () {
            messageController.like(
                messageType: MessageType.reply,
                messageId: messageId,
                postId: reply.replyId);
          },
        ));
  }
}
