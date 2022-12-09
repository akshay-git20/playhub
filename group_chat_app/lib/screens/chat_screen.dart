// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:group_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  static String id = "/chatscreen";
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messegecontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loggedinuser;
  String messegetext = "";
  void getcurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(firestore: _firestore, loggedinuser: loggedinuser!),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messegecontroller,
                      onChanged: (value) {
                        messegetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messegecontroller.clear();
                      _firestore.collection('messeges').add(
                          {'text': messegetext, 'sender': loggedinuser!.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required FirebaseFirestore firestore,
    required this.loggedinuser,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;
  final User loggedinuser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection('messeges').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          final messages = snapshot.data?.docs.reversed;
          List<Mesaagebubble> messageBubbles = [];
          for (var message in messages!) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final cuurentuser = loggedinuser.email;
            final messegebubble = Mesaagebubble(
              messageText: messageText,
              messageSender: messageSender,
              isMe: cuurentuser == messageSender,
            );
            messageBubbles.add(messegebubble);
          }
          return ListView(
            reverse: true,
            children: messageBubbles,
          ).expand();
        }));
  }
}

class Mesaagebubble extends StatelessWidget {
  final messageText;
  final messageSender;
  final bool isMe;
  const Mesaagebubble({
    Key? key,
    required this.messageText,
    required this.messageSender,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          messageSender,
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
        Material(
          elevation: 7.0,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))
              : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
          color: isMe ? Colors.lightBlueAccent : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              '   $messageText',
              style: TextStyle(
                  color: isMe ? Colors.white : Colors.black, fontSize: 20),
            ),
          ),
        ),
      ],
    ).p16();
  }
}
