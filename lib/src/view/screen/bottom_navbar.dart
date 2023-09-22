import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/core/app_color.dart';
import 'package:office_app_store/core/app_data.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/model/LoggedInUser.dart';
import 'package:office_app_store/src/view/screen/cart_screen.dart';
import 'package:office_app_store/src/view/screen/forum_screen.dart';
import 'package:office_app_store/src/view/screen/scheme_screen.dart';
import 'package:office_app_store/src/view/screen/home_screen.dart';
import 'package:office_app_store/src/view/screen/crop_recommendation_screen.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';
import '../../controller/office_furniture_controller.dart';
import 'detection_screen.dart';

final OfficeFurnitureController controller =
    Get.put(OfficeFurnitureController());
final MessageController messageController = Get.put(MessageController());

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber?.substring(3))
        .get()
        .then((value) {
      print("here");
      loggedInUser.value = LoggedInUser(
          name: value['name'],
          phone: FirebaseAuth.instance.currentUser?.phoneNumber?.substring(3) ??
              "",
          district: value['district'],
          state: value['state'],
          isExpert: value['isExpert']);
    });

    super.initState();
  }

  final List<Widget> screens = [
    //const HomeScreen(),
    Classifier(),
    const ForumScreen(),
    CropRecommendationScreen(),
    FeedScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.currentBottomNavItemIndex.value,
            showUnselectedLabels: true,
            onTap: controller.switchBetweenBottomNavigationItems,
            //fixedColor: AppColor.lightBlack,
            items: AppData.bottomNavigationItems
                .map(
                  (element) => BottomNavigationBarItem(
                      icon: element.icon, label: element.label),
                )
                .toList(),
          );
        },
      ),
      body: Obx(() => screens[controller.currentBottomNavItemIndex.value]),
    );
  }
}
