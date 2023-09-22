import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/view/widget/message_widget.dart';
import 'package:office_app_store/src/view/widget/post_bottom_sheet.dart';
import '../../../core/app_style.dart';
import 'bottom_navbar.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Q&A Forum", style: h2Style),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.bottomSheet(PostBottomSheet(
            messageType: MessageType.post,
          ));
        },
        label: Text('Post'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => MessageWidget(
            message: messageController.messages[index],
          ),
          separatorBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.grey,
            height: 1,
          ),
          itemCount: messageController.messages.length,
        );
      }),
    );
  }
}
