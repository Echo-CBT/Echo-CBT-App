import 'package:flutter/material.dart';

import 'package:parallax/screens/chatScreen.dart';
import 'package:parallax/models/chatModel.dart';

class ChatCard extends StatelessWidget {

  ChatModel chat;

  ChatCard({
    this.chat
  });

  @override
  Widget build(BuildContext context) {
    // print("chatCard.dart");
    // print(chat);
    return GestureDetector(
        onTap: (){
          // print("Pushing!");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chat: chat),
            ),
          );
        },
          child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
        // color: Colors.black,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                Expanded(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        chat.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      // Text(
                      //   "Somethign Something",
                      //   textAlign: TextAlign.start,
                      // ),
                    ],
                  ),
                ),
                // CircleAvatar(
                //   backgroundColor: Colors.black87,
                //   child: Text("2"),
                //   maxRadius: 12
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
