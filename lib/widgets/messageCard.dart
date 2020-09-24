import 'package:flutter/material.dart';
import '../screens/commentsPage.dart';
import 'package:random_color/random_color.dart';



class MessageCard extends StatefulWidget {

  var message;
  MessageCard({this.message});

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  static RandomColor randomColor = RandomColor();
  Color _color = randomColor.randomColor(
      colorSaturation: ColorSaturation.highSaturation,
      colorHue: ColorHue.orange
  );

  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  CommentsPage(postId : widget.message["_id"])));
      },
      child: Card(
        // color: Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        // shape: ,
        child: Container(
          // margin: EdgeInsets.all(10),
          color: Colors.white,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 10),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: _color,
                            child: Text(
                                widget.message['name'][0],
                              style: TextStyle(
                                color: Colors.white
                              )
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.message['name'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
//                              Container(
//                                margin: EdgeInsets.only(left: 25),
//                                child: Text(
//                                    difference.toString()
//                                ),
//                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.message['story'],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: Text(
                      "Message ${widget.message["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    color: _color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
