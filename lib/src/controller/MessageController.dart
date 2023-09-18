import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/model/messageModel.dart';

class MessageController extends GetxController {
  RxList<Message> messages = RxList<Message>();
  @override
  void onInit() {
    messages.bindStream(lista());
    // messages.bindStream(FirebaseFirestore.instance
    //     .collection("message")
    //     .snapshots()
    //     .map((event) {
    //   return event.docs.map((QueryDocumentSnapshot<Map> e) {
    //     var messageData = e.data();
    //     FirebaseFirestore.instance
    //         .collection('message')
    //         .doc(e.id)
    //         .collection('replies')
    //         .get()
    //         .then((replyDocument) {
    //       return Message(
    //           messageData['isExpert'],
    //           messageData['message'],
    //           messageData['name'],
    //           replyDocument.docs.map((reply) {
    //             var replyData = reply.data();
    //             print(replyData);
    //             return Reply(replyData['likes'], replyData['message'],
    //                 replyData['sender']);
    //           }).toList());
    //     });
    //   }).toList();
    // }));
    super.onInit();
  }

  Stream<List<Message>> lista() {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection("message").snapshots();

    return stream.map((event) => event.docs.map((message) {
          RxList<Reply> reply = RxList<Reply>();
          reply.bindStream(message.reference
              .collection("replies")
              .snapshots()
              .map((replyCollection) => replyCollection.docs
                  .map((e) => Reply(e['likes'], e['message'], e['sender']))
                  .toList()));
          return Message(
              message['isExpert'], message['message'], message['name'], reply);
        }).toList());
  }
}
