import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  final String title;
  final Color color;
  final Function updateActivites;

  ActivityCard({
    this.title,
    this.color,
    this.updateActivites,
  });

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.updateActivites(widget.title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.color != null ? widget.color : Colors.black26,
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.all(5),
        child: Wrap(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   margin: EdgeInsets.all(5),
                //   child: Icon(Icons.assessment),
                // ),
                Container(
                  // padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  padding: EdgeInsets.all(9),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
