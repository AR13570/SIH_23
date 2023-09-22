import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/model/messageModel.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';
import 'package:office_app_store/src/view/widget/post_bottom_sheet.dart';
import 'package:office_app_store/src/view/widget/reply_widget.dart';

import '../screen/bottom_navbar.dart';

// class MessageWidget extends StatelessWidget {
//   final Message message;
//   const MessageWidget({super.key, required this.message});
//
//   @override
//   Widget build(BuildContext context) {}
// }

ExpansionTileItem messageWidget({required Message message}) {
  return ExpansionTileItem(
    isHasTrailing: false,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green)),
    textColor: Colors.black,
    backgroundColor: Colors.grey.shade200,
    childrenPadding: const EdgeInsets.all(15),
    leading: CircleAvatar(
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
      backgroundColor: Colors.grey,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${message.name}",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
        ),
        Row(
          children: [
            Chip(
              label: Text("${message.likes.length}"),
              deleteIcon: Icon(
                !message.likes.contains(loggedInUser.value.phone)
                    ? Icons.thumb_up
                    : Icons.thumb_down,
                size: 17,
              ),
              onDeleted: () {
                messageController.like(
                  messageType: MessageType.post,
                  messageId: message.messageId,
                );
              },
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              child: const Chip(label: Text("Reply")),
              onTap: () {
                Get.bottomSheet(PostBottomSheet(
                  messageType: MessageType.reply,
                  messageId: message.messageId,
                ));
              },
            ),
          ],
        )
      ],
    ),
    subtitle: message.replies.isNotEmpty
        ? Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8),
              child: Text(
                "${message.replies.length} ${message.replies.length > 1 ? "replies" : "reply"}",
                style: TextStyle(color: Colors.blueAccent.shade200),
              ),
            ),
          )
        : Container(),
    children: message.replies.isNotEmpty
        ? message.replies
            .map((Reply reply) => ReplyWidget(
                  reply: reply,
                  messageId: message.messageId,
                  selected: reply.likes.contains(loggedInUser.value.phone),
                ))
            .toList()
        : [
            Center(
              child: const Text(
                "No comments yet",
              ),
            )
          ],
  );
}
