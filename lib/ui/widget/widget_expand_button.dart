import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  final String text;

  final Color color;

  final Color textColor;

  final VoidCallback onPress;

  final double fontSize;

  final int maxLines;

  final MainAxisAlignment mainAxisAlignment;

  ExpandButton({
    Key key,
    this.text,
    this.color,
    this.textColor,
    this.onPress,
    this.fontSize = 20,
    this.maxLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        this.onPress?.call();
      },
      color: color,
      textColor: textColor,
      padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10.0, right: 20.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
