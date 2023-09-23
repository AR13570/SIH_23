import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/model/messageModel.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';

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
        onLongPress: () {
          if (reply.name == loggedInUser.value.name) {
            Get.defaultDialog(
                title: "Delete",
                middleText: "Do you want to delete this message?",
                onConfirm: () {
                  messageController.deleteComment(
                      messageType: MessageType.reply,
                      messageId: messageId,
                      replyId: reply.replyId);
                });
          }
        },
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
        subtitle: Row(
          children: [
            Text(
              reply.name,
            ),
            SizedBox(
              width: 5,
            ),
            if (reply.isExpert)
              Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 14,
              )
          ],
        ),
        trailing: Chip(
          label: Text("${reply.likes.length}"),
          deleteIcon: Icon(
            !selected ? Icons.thumb_up_alt_outlined : Icons.thumb_up,
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
