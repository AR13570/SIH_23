import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/model/messageModel.dart';

class MessageController extends GetxController {
  RxList<Message> messages = RxList<Message>();
  @override
  void onInit() {
    //bind lets you automatically link a list
    // to the stream for real-time updates
    messages.bindStream(bindMessages());
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

  Stream<List<Message>> bindMessages() {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection("message").snapshots();

    return stream.map((event) => event.docs.map((message) {
          //Create a separate obx list for replies
          //Bind this list with the replies of current message
          // before binding the message (to prevent Future->null issues)
          RxList<Reply> replies = RxList<Reply>();
          replies.bindStream(message.reference
              .collection("replies")
              .snapshots()
              .map((replyCollection) => replyCollection.docs
                  .map((replyData) => Reply(
                      replyId: replyData.id,
                      likes: replyData['likes'],
                      message: replyData['message'],
                      sender: replyData['sender']))
                  .toList()));
          //finally bind the message list to the message collection
          return Message(
              messageId: message.id,
              isExpert: message['isExpert'],
              message: message['message'],
              name: message['name'],
              replies: replies);
        }).toList());
  }
}
