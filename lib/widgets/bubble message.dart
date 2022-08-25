import 'package:flutter/material.dart';

class bubbleMessages extends StatelessWidget {
  bubbleMessages(this.messages, this.isme, this.username, {this.key});
  final String messages;
  final bool isme;
  final Key key;
  final String username;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isme ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isme ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isme ? Radius.circular(0) : Radius.circular(12),
                ),
                color: isme ? Colors.blueGrey : Theme.of(context).accentColor),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: isme ? TextAlign.end : TextAlign.start,
                ),
                Text(
                  messages,
                  textAlign: isme ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                      color: isme
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color),
                ),
              ],
            ),
          ),
        ]);
  }
}
