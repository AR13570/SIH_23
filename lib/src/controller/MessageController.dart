import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/model/messageModel.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';

enum MessageType { post, reply }

//TODO this user is for testing, replace this with logged in user

class MessageController extends GetxController {
  RxList<Message> messages = RxList<Message>();
  @override
  void onInit() {
    //bind lets you automatically link a list
    // to the stream for real-time updates
    messages.bindStream(bindMessages());

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
                      //likes: replyData['likes'],
                      likes: replyData['liked by'],
                      message: replyData['message'],
                      sender: replyData['user']))
                  .toList()));
          //finally bind the message list to the message collection
          return Message(
              messageId: message.id,
              isExpert: message['isExpert'],
              likes: message['liked by'],
              message: message['message'],
              name: message['user'],
              replies: replies);
        }).toList());
  }

  postMessage(
      {required String message, required String name, required bool isExpert}) {
    FirebaseFirestore.instance.collection("message").add({
      'user': name,
      'message': message,
      'isExpert': isExpert,
      'liked by': []
    }).then((value) => Get.back());
  }

  postReply(
      {required String message,
      required String name,
      required bool isExpert,
      required String messageId}) {
    FirebaseFirestore.instance
        .collection("message")
        .doc(messageId)
        .collection("replies")
        .add({
      'user': name,
      'message': message,
      'isExpert': isExpert,
      'liked by': []
    }).then((value) => Get.back());
  }

  like(
      {required MessageType messageType,
      required String messageId,
      String? postId}) {
    DocumentReference messageDocument =
        FirebaseFirestore.instance.collection("message").doc(messageId);
    if (messageType == MessageType.post) {
      FirebaseFirestore.instance
          .collection("message")
          .doc(messageId)
          .get()
          .then((value) {
        var data = value.data();
        List likedBy = data?["liked by"];
        if (likedBy.contains(loggedInUser.value.phone)) {
          FirebaseFirestore.instance
              .collection("message")
              .doc(messageId)
              .update({
            "liked by": FieldValue.arrayRemove([loggedInUser.value.phone])
          });
        } else {
          FirebaseFirestore.instance
              .collection("message")
              .doc(messageId)
              .update({
            "liked by": FieldValue.arrayUnion([loggedInUser.value.phone])
          });
        }
      });
    } else {
      messageDocument.collection("replies").doc(postId!).get().then((value) {
        var data = value.data();
        List likedBy = data?["liked by"];
        if (likedBy.contains(loggedInUser.value.phone)) {
          messageDocument.collection("replies").doc(postId).update({
            "liked by": FieldValue.arrayRemove([loggedInUser.value.phone])
          });
        } else {
          messageDocument.collection("replies").doc(postId).update({
            "liked by": FieldValue.arrayUnion([loggedInUser.value.phone])
          });
        }
      });
      // messageDocument
      //     .collection("replies")
      //     .doc(postId!)
      //     .update({"likes": FieldValue.increment(selected ? 1 : -1)});
    }
  }
}
