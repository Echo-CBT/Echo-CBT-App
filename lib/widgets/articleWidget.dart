import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:parallax/scoped_models/mainModel.dart';
import 'package:parallax/models/articleModel.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({
    @required this.suggActivites,
  });

  final dynamic suggActivites;

  @override
  _ArticleWidgetState createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  dynamic articles;

  var r = new Random();

  @override
  void initState() {
    super.initState();
    final MainModel model = MainModel();
    initializePage(model);
  }

  void initializePage(MainModel model) async {
    //var a=await model.getArticles();
    var a = await model.getAllArticles(widget.suggActivites);
    // print("A:");
    // print(a);
    //var b = ArticlesModel(articles: a["payload"]).articles;
    var b = ArticlesModel(articles: a).articles;
    // print("B:");
    // print(b);
    setState(() {
      articles = b;
    });
  }

  _launchURL(String url) async {
    // print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget articleCard(dynamic article) {
    var a = r.nextInt(100) % 9;
    if(a==0) {
      a = 1;
    }
    // return Container(
    return SizedBox(
      height: 330,
      child: GestureDetector(
        onTap: () {
          //_launchURL(article["url"]);
          _launchURL(article["link"]);
          // print(article);
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  // "We found something interesting",
                  article["title"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                // SizedBox(
                //   height: 2,
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   'images/clumsy.png',
                    //   // height: MediaQuery.of(context).size.height,
                    //   width: MediaQuery.of(context).size.width*1.0,
                    // ),
                    Image.asset(
                      // article["imageUrl"]!=null?article["imageUrl"]:'images/clumsy.png',
                      //article["image"],
                      imageUrls[r.nextInt(4)%4],
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: MediaQuery.of(context).size.width * 1.0,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 6,
                // ),
                Text(
                  // "Creating the perfect work-life balance",
                  "",
                  //article["token"].toUpperCase(),
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                ),
                // SizedBox(
                //   height: 1,
                // ),
                Text(
                    // "6 min read"
                    a.toString() + " min read"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> makeArticleList() {
    var arr = <Widget>[];
    if (articles == null) {
      return [Container()];
    }
    for (int i = 0; i < articles.length; i++) {
      //  print("Article[$i]");
      //  print(articles[i]);
      //  print(articles.runtimeType);
      arr.add(Container(
        margin: EdgeInsets.all(15),
        child: articleCard(articles[i]),
      ));
    }
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          // <Widget>[

          // ],
          makeArticleList(),
    );
    // Container(
    //   child: makeArticleList(),
    // );
  } //articleCard()
}

var imageUrls = ['images/pic1.jpeg', 'images/pic2.jpeg', 'images/pic3.jpeg', 'images/pic4.jpeg'];
  /*var imageUrls = [
    'https://www.google.com/imgres?imgurl=https%3A%2F%2Fus.123rf.com%2F450wm%2Fflynt%2Fflynt1603%2Fflynt160300043%2F54427907-man-using-scissors-to-remove-the-word-can-t-to-read-i-can-do-it-concept-for-self-belief-positive-att.jpg%3Fver%3D6&imgrefurl=https%3A%2F%2Fwww.123rf.com%2Fstock-photo%2Fpositive.html&tbnid=c9EGR8No1uthFM&vet=12ahUKEwib-ZHI3P7qAhWLXn0KHUXMDPUQMygHegUIARDRAQ..i&docid=tYxYsTa7mhNAlM&w=450&h=311&q=positive%20photos&client=firefox-b-d&ved=2ahUKEwib-ZHI3P7qAhWLXn0KHUXMDPUQMygHegUIARDRAQ',
    "data:image/jpeg;base64,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",
    "data:image/jpeg;base64,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",
    "data:image/jpeg;base64,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",
  ];*/
