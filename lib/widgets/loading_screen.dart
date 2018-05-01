import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            new CircularProgressIndicator(
              value: null,
              strokeWidth: 7.0,
            ),
          ]))
    ]);
  }
}
