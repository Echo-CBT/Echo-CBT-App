import 'package:flutter/material.dart';

import 'package:parallax/widgets/activityCard.dart';
import 'package:parallax/scoped_models/mainModel.dart';

class ActivityWidget extends StatefulWidget {

  const ActivityWidget({
    @required this.setSuggActivites,
  });
  
  final Function setSuggActivites;

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  List<dynamic> chipTitles = [];

  @override
  void initState() {
    super.initState();
    final MainModel model = MainModel();
    initializePage(model);
  }

  void initializePage(MainModel model) async {
    var a = await model.getAllAcitivityForHomePage();
    widget.setSuggActivites(a);
    setState(() {
      chipTitles = a;
    });
    // print(a);
    // print(a.runtimeType);

    // var data1;
    // await a.then((data){
    //   data1=data;
    // });
    // print(data1);
  }

  List<Widget> buildActivityCards() {
    List<Widget> arr = [];
    var a = chipTitles.map(
      (data) {
        return arr.add(
          ActivityCard(
            title: data.toLowerCase(),
          ),
        );
      },
    );
    print(a);
    print(arr);
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "You might love doing these today!",
            style: TextStyle(fontSize: 17.7, fontWeight: FontWeight.w800),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              // crossAxisAlignment: WrapCrossAlignment.center,
              // runAlignment: WrapAlignment.center,
              // textDirection: TextDirection.ltr,
              alignment: WrapAlignment.center,
              children: chipTitles != []
                  ? buildActivityCards()
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              // <Widget>[
              //   ActivityCard(title: "Jogging",),
              //   ActivityCard(title: "Frogging",),
              //   ActivityCard(title: "Watch Cinema",),
              //   ActivityCard(title: "Netflix",),
              //   ActivityCard(title: "Coding",),
              //   ActivityCard(title: "Music",),
              //   ActivityCard(title: "Dancing",),
              //   ActivityCard(title: "Painting",),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}
