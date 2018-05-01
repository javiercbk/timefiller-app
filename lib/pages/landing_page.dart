import 'package:flutter/material.dart';
import './accounts_page.dart';
import './user_state.dart';
import './worklog_list_widget.dart';

const String _accounts = 'accounts';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends UserState<LandingPage> {
  _navigateAcconts() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new AccountsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.settings;
    var _onPressed = _navigateAcconts;
    Widget _body =
        new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      new Expanded(
          child: new ListTile(
              leading: const Icon(Icons.build),
              title: new Text("Timefiller must be configured")))
    ]);
    if (user != null && user.hasTargetTimeTracker) {
      icon = Icons.add;
      // TODO navigate to create work log
      _onPressed = () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new AccountsPage()),
        );
      };
      _body = new WorklogListWidget();
    }
    return new Scaffold(
        appBar: new AppBar(title: const Text('Timefiller'), actions: [
          new PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (String val) {
                if (val == _accounts) {
                  _navigateAcconts();
                }
              },
              itemBuilder: (_) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        child: const Text('Accounts'), value: _accounts)
                  ]),
        ]),
        body: _body,
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0, child: new Icon(icon), onPressed: _onPressed));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  // const Choice(title: 'Car', icon: Icons.more_vert),
];
