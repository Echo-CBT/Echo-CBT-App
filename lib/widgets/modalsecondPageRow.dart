//172.17.235.30:8080/getSuggestion

import 'package:flutter/material.dart';

import 'package:parallax/widgets/activityCard.dart';

class SecondPageRow extends StatelessWidget {
  final String title;
  final List<String> chipTitles, activities;
  final Function updateActivites;

  SecondPageRow({
    this.title,
    this.chipTitles,
    this.activities,
    this.updateActivites,
  });

  List<Widget> something() {
    List<Widget> arr = [];

    var a = chipTitles.map(
      (data) {
        Color color = Colors.black26;
        print(activities);
        print(activities.contains(data));
        if (activities.contains(data)) {
          color = Colors.lightBlue;
        }
        return arr.add(
          ActivityCard(
            title: data,
            color: color,
            updateActivites: updateActivites,
          ),
        );
      },
    );
    print(a);
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              title,
              textAlign: TextAlign.left,
            ),
          ),
          // Row(
          Wrap(
              // mainAxisAlignment: MainAxisAlignment.center,
              alignment: WrapAlignment.center,
              children: something()
              //     <Widget>[
              //     // ActivityCard(title: "Jogging"),
              //     // ActivityCard(title: "Watch Cinema"),

              //  ],
              ),
        ],
      ),
    );
  }
}
