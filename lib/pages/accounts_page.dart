import 'package:flutter/material.dart';
import 'dart:async';
import '../model/models.dart';
import './user_state.dart';
import '../widgets/loading_screen.dart';
import './jira_configuration_page.dart';
import './harvest_configuration_page.dart';
import './waka_configuration_page.dart';
import '../widgets/image.dart' as images;

bool _notNull(dynamic obj) {
  return obj != null;
}

bool _null(dynamic obj) {
  return obj == null;
}

Future<T> _navigate<T>(BuildContext context, WidgetBuilder widgetBuilder) {
  return Navigator.push<T>(
    context,
    new MaterialPageRoute(builder: widgetBuilder),
  );
}

Future<User> _editJira(BuildContext context) {
  return _navigate<User>(context, (context) => new JiraConfigurationPage());
}

Future<User> _editHarvest(BuildContext context) {
  return _navigate<User>(context, (context) => new HarvestConfigurationPage());
}

Future<User> _editWakatime(BuildContext context) {
  return _navigate<User>(context, (context) => new WakaConfigurationPage());
}

Function _addAccount(BuildContext context) {
  return () {
    _navigate(context, (context) => new _AddAccountPage());
  };
}

IconTheme _buildIcon(AssetImage assetImage) {
  return new IconTheme(
      child: new Image(
        image: assetImage,
        color: null,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      ),
      data: new IconThemeData(color: null));
}

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPage createState() => new _AccountsPage();
}

class _AccountsPage extends AccountsList<AccountsPage> {
  Widget _buildComponent() {
    final widgets = _editList(context, user, true);
    if (widgets.length < 3) {
      if (widgets.length > 0) {
        widgets.add(const Divider());
      }
      widgets.add(new ListTile(
        leading: new Icon(Icons.add),
        title: new Text('Add an account'),
        onTap: _addAccount(context),
      ));
    }
    return new ListView(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    Widget component;
    if (initialized) {
      component = _buildComponent();
    } else {
      initialize();
      component = new LoadingScreen();
    }
    return new Scaffold(
        appBar: new AppBar(title: const Text('Accounts')), body: component);
  }
}

class _AddAccountPage extends StatefulWidget {
  @override
  __AddAccountPage createState() => new __AddAccountPage();
}

class __AddAccountPage extends AccountsList<_AddAccountPage> {
  Widget _buildAddAccountsComponent() {
    final widgets = _editList(context, user, false);
    return new ListView(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    Widget component;
    if (initialized) {
      component = _buildAddAccountsComponent();
    } else {
      initialize();
      component = new LoadingScreen();
    }
    return new Scaffold(
        appBar: new AppBar(title: const Text('Add account')), body: component);
  }
}

typedef Future<User> AccountNavigation(BuildContext context);
typedef void VoidCallback();

abstract class AccountsList<T extends StatefulWidget> extends UserState<T> {
  VoidCallback _wrapTapCall(AccountNavigation navigate) {
    return () async {
      final newUser = await navigate(context);
      if (newUser != null) {
        setState(() {
          user = newUser;
        });
      }
    };
  }

  List<Widget> _editList(BuildContext context, User user, bool addIfDefined) {
    final widgets = new List<Widget>();
    var condition = _null;
    if (addIfDefined) {
      condition = _notNull;
    }
    if (condition(user.jira)) {
      widgets.add(new ListTile(
          leading: _buildIcon(images.jira()),
          title: new Text('Jira'),
          onTap: _wrapTapCall(_editJira)));
    }
    if (condition(user.harvest)) {
      if (widgets.length > 0) {
        widgets.add(const Divider());
      }
      widgets.add(new ListTile(
          leading: _buildIcon(images.harvest()),
          title: new Text('Harvest'),
          onTap: _wrapTapCall(_editHarvest)));
    }
    if (condition(user.waka)) {
      if (widgets.length > 0) {
        widgets.add(const Divider());
      }
      widgets.add(new ListTile(
          leading: _buildIcon(images.wakatime()),
          title: new Text('Wakatime'),
          onTap: _wrapTapCall(_editWakatime)));
    }
    return widgets;
  }
}
