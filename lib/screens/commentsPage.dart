import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
FirebaseUser loggedInUser;

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
  final postId;
  CommentsPage({this.postId});
}

class _CommentsPageState extends State<CommentsPage> {
  final _auth = FirebaseAuth.instance;
  void getCurrentUser () async {
    try{
      final user = await _auth.currentUser();
      if(user!=null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }
  Future<http.Response> getAllPosts() {
    print(widget.postId);
    return http.get('https://echo-cbt-server.herokuapp.com/user/story/fetchComments?storyId=${widget.postId}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${loggedInUser.uid}'
        });
  }

  var comments = null;
  TextEditingController _textController=TextEditingController();


  Future<http.Response> submitComment() {
    return http.post(
      'https://echo-cbt-server.herokuapp.com/user/story/comment',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${loggedInUser.uid}'
      },
      body: jsonEncode(<String, String>{
        'comment': _textController.text,
        "name" : loggedInUser.displayName.toString(),
        "uid" : loggedInUser.uid.toString(),
        'storyId': widget.postId.toString()
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
    getCurrentUser();
  }

  void _initializePage() async {
    print("FETCHING COMMENTS!");
    var allPosts = await getAllPosts();
    final parsed = jsonDecode(allPosts.body);
    print(parsed['payload']);
    setState(() {
      comments = parsed['payload']['comments'];
    });
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Comments",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      body: Column(
        children: <Widget>[
          comments == null
              ?
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
          :
              comments.length == 0
          ?
          Center(
            child: Text(
              "No comments to show!",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),
            ),)
              :
          Expanded(
            child: ListView.builder(
                itemCount: comments.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  final item = comments[index];
                  return Container(
                    child: Card(

                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      // shape: ,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.orange,
                            child: Text(item['name'][0]),
                            foregroundColor: Colors.white,
                          ),
                          title: Text(
                            item['name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          subtitle: Text(
                            item['comment'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),

          ),
          comments == null
              ?
          Container()
          :
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                // labelText: "Type here",
                suffixIcon: IconButton(
                    onPressed: () async{
                      print('Creating Comment!');
                      await submitComment();
                      _initializePage();
                    },
                    icon: Icon(Icons.send)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      )


    );
  }
}

//name