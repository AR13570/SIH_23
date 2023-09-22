import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/model/subsidaryModel.dart';

class SubsidaryController extends GetxController {
  RxList<SubsidaryModel> subsidiaries = RxList<SubsidaryModel>();
  RxList<Interest> interests = RxList<Interest>();

  @override
  void onInit() {
    subsidiaries.bindStream(FirebaseFirestore.instance
        .collection("subsidiaries")
        .snapshots()
        .map((event) => event.docs.map((e) {
              return SubsidaryModel(e['cinfo'], e['data'], e['name'], e['web']);
            }).toList()));

    interests.bindStream(FirebaseFirestore.instance
        .collection("interest")
        .snapshots()
        .map((event) => event.docs.map((e) {
              return Interest(e['ir'], e['loan']);
            }).toList()));
    super.onInit();
  }
}
