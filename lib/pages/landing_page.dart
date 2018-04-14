import 'package:flutter/material.dart';
import './configuration_page.dart';
import './user_state.dart';
import './worklog_list_widget.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends UserState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var icon = Icons.settings;
    var _onPressed = () {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new ConfigurationPage()),
      );
    };
    Widget _body =
        new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      new Expanded(
          child: new ListTile(
              leading: const Icon(Icons.build),
              title: new Text("Timefiller must be configured")))
    ]);
    if (user != null && user.completed) {
      icon = Icons.add_circle;
      // TODO navigate to create work log
      _onPressed = () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new ConfigurationPage()),
        );
      };
      _body = new WorklogListWidget();
    }
    return new Scaffold(
        appBar: new AppBar(title: const Text('Timefiller')),
        body: _body,
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0, child: new Icon(icon), onPressed: _onPressed));
  }
}
