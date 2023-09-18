import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePostingScreen extends StatefulWidget {

  @override
  _MessagePostingScreenState createState() => _MessagePostingScreenState();

}

class _MessagePostingScreenState extends State<MessagePostingScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final RxBool isExpert = false.obs; // Use RxBool from GetX

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Message'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person), // Add an icon to the "Name" field
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () {
                  _messageController.clear();
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Add a comment...',
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Is Expert?'),
                  SizedBox(width: 8.0),
                  Obx(
                        () => Switch(
                      value: isExpert.value,
                      onChanged: (value) {
                        isExpert.value = value; // Update using GetX's reactive variable
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {

                  String name = _nameController.text;
                  String message = _messageController.text;

                  bool expertStatus = isExpert.value;


                  CollectionReference messagesCollection =
                  FirebaseFirestore.instance.collection('message');

                  try {

                    DocumentReference messageDocument = await messagesCollection.add({
                      'name': name,
                      'message': message,
                      'isExpert': expertStatus,
                    });


                    _nameController.clear();
                    _messageController.clear();


                    CollectionReference repliesCollection = messageDocument.collection('replies');



                    DocumentReference replyDocument = await repliesCollection.add({
                      'sender': '', // Assuming the sender is the same as the message sender
                      'likes': 0,     // Initial likes count for the reply
                      'message': "",
                    });


                    print('Message uploaded with ID: ${messageDocument.id}');
                    print('Reply uploaded with ID: ${replyDocument.id}');
                  } catch (error) {

                    print('Error uploading message and reply: $error');
                  }
                },
                child: Text('Post query'),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
