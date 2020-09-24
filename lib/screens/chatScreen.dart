import 'package:flutter/material.dart';

import 'package:parallax/models/chatModel.dart';
import 'package:parallax/scoped_models/mainModel.dart';
class ChatScreen extends StatefulWidget {

  ChatModel chat;

  ChatScreen({
    this.chat
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController _textController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final MainModel model=MainModel();
    initializePage(model);
  }

  void initializePage(MainModel model) async {
    // model.getAll
    print(widget.chat.chatId);
    var a=await model.getAllMessages(widget.chat.chatId);
    print(a["payload"]["messages"]);
    // var data1;
    // await a.then((data){
    //   data1=data;
    // });
    // print(data1);
    // print(data1.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Something",
          style: TextStyle(
            color: Colors.black
          )
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: (){},
          ),
        ],
      ),
     body: Column(
       children: <Widget>[
         Expanded(
          child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
            var a, b;
            if(index%2==0)
              {
                a=TextAlign.end;
                b=Alignment.centerLeft;
              }
            else{
              a=TextAlign.start;
              b=Alignment.centerRight;
            }
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3
              ),
              width: double.infinity,
              //  color: Colors.black12,
              child: Container(
                alignment: b,
                padding: EdgeInsets.all(10),
                // color: Colors.black26,
                child: Text(
                  "Something!",
                  textAlign: a,
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
            );
          }
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              // labelText: "Type here",
              suffixIcon: Icon(Icons.send),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        // Container(
        //   child: Row(
        //     children: <Widget>[
        //       // Text("Soethign'")
        //       RaisedButton(
        //         onPressed: (){},
        //       ),
        //     ],
        //   ),
          
        //   decoration: BoxDecoration(
        //     border: Border(
        //     )
        //   ),
        // ),  
        //     // RaisedButton(
        //     //   onPressed: (){},
        //     //   child: Container(
        //     //     child: Text("Somethign!"),
        //     //   ),
        //     // ),
       ],
     ),
      // bottomSheet: BottomSheet(onClosing: null, builder: null),
      
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        elevation: 10,
        child: Row(
          children: <Widget>[
            // Container(
            //   // child: TextField(
            //   //   controller: _textController,
            //   //   decoration: InputDecoration(
            //   //     labelText: "Type Here!",
            //   //     fillColor: Colors.black,
            //   //     border: OutlineInputBorder(
            //   //       borderRadius: BorderRadius.circular(10)
            //   //     )
            //   //   ),
            //   // ),
            // ),
            // TextFormField(
            //   controller: _textController,
            //   cursorColor: Colors.black,
            //   decoration: InputDecoration(
            //     // alignLabelWithHint: true,
            //     contentPadding: EdgeInsets.all(3),
            //     fillColor: Colors.black,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10)
            //     ),
            //   ),
            //   style: TextStyle(
            //     color: Colors.black
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
