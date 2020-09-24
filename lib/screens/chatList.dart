import 'package:flutter/material.dart';

import 'package:parallax/widgets/chatCard.dart';
import 'package:parallax/scoped_models/mainModel.dart';
import 'package:parallax/scoped_models/shared.dart';
import 'package:parallax/models/user.dart';
import 'package:parallax/models/chatModel.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  dynamic arr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final MainModel model=MainModel();
    initializePage(model);
  }

  void initializePage(MainModel model) async {
    var a=Shared.getUserDetails();
    // print(a.runtimeType);
    var b;
    await a.then((data){
      b=data;
    });
    // print(b);
    // print(b["uid"]);
    var d=model.getAllChats(b["uid"]);
    var data1;
    await d.then((data){
      data1=data;
    });
    // data1
    setState(() {
      arr=ChatsModel.fromJson(data1["payload"]["messagesFrom"]).chats;
    });
    // print(arr);


    // print(arr);
    // print(arr.runtimeType);
    // print(arr.toString());
    // print(d);
    // print(d.runtimeType);

    // print(user.uid);
    // model.getAllChats(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Inbox",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    body: arr==null
    ?
    Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
    :
    ListView.builder(
      itemCount: arr.length,
      itemBuilder: (BuildContext context, int index){
        return Container(
          child: ChatCard(chat: arr[index]),
       );
      }
     ),
    );
  }
}
