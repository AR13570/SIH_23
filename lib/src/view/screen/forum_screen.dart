import 'package:expansion_tile_group/expansion_tile_group.dart';
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
        title: const Text("Agro Community", style: h2Style),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ExpansionTileGroup(
              spaceBetweenItem: 16,
              children: messageController.messages
                  .map((element) => messageWidget(
                        message: element,
                      ) as ExpansionTileItem)
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}
