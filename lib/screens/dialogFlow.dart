import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/mainModel.dart';
import '../scoped_models/shared.dart';

class HomePageDialogflow extends StatefulWidget {
  HomePageDialogflow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  MainModel _model;
  String name;

  @override
  void initState() {
    _model = ScopedModel.of(context);
    _initializePage(_model);
    _logFirstMssg("Hello! Let\'s talk about how was your day?");
    super.initState();
  }

  void _initializePage(MainModel _model) async {
    var _user = await Shared.getUserDetails();
    name = _user.name;
    ChatMessage message;
    try {
      var entries = await _model.getDiaryEntries();
      print(entries);
      print(entries.length);
      print(entries[0]);
      for (int i = 0; i < entries.length; i++) {
        message = ChatMessage(
          text: entries[i]['entry'],
          name: name,
          type: true,
        );
        setState(() {
          _messages.insert(0, message);
        });
      }
    } catch (err) {
      print(err);
      message = ChatMessage(
        text:
            "An error occured, while getting previous entries, please try again later",
        name: "EchoBot",
        type: false,
      );
      setState(() {
        _messages.insert(0, message);
      });
    }
  }

  void _logFirstMssg(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: "EchoBot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 0),
              child: new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,
      name: "Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _recordDiary(String text) async {
    _textController.clear();
    ChatMessage message;
    try {
      await _model.recordDiary(text);
      message = ChatMessage(
        text: "Thanks we hope you have a great day!",
        name: "EchoBot",
        type: false,
      );
    } catch (err) {
      print(err);
      message = ChatMessage(
        text:
            "An error occured, while recording your input, please try again later",
        name: "EchoBot",
        type: false,
      );
    }
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: name,
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _recordDiary(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: new Text(
          "Daily Logs",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(children: <Widget>[
        Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        //width: type ? MediaQuery.of(context).size.width * 0.05 : MediaQuery.of(context).size.width * 0.1,
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('EB')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: type ? MediaQuery.of(context).size.width * 0.0 : MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            child: new Text(
          this.name[0],
          style: new TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
