import 'package:flutter/material.dart';
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

void _navigate(BuildContext context, WidgetBuilder widgetBuilder) {
  Navigator.push(
    context,
    new MaterialPageRoute(builder: widgetBuilder),
  );
}

Function _editJira(BuildContext context) {
  return () {
    _navigate(context, (context) => new JiraConfigurationPage());
  };
}

Function _editHarvest(BuildContext context) {
  return () {
    _navigate(context, (context) => new HarvestConfigurationPage());
  };
}

Function _editWakatime(BuildContext context) {
  return () {
    _navigate(context, (context) => new WakaConfigurationPage());
  };
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
        onTap: _editJira(context)));
  }
  if (condition(user.harvest)) {
    if (widgets.length > 0) {
      widgets.add(const Divider());
    }
    widgets.add(new ListTile(
        leading: _buildIcon(images.harvest()),
        title: new Text('Harvest'),
        onTap: _editHarvest(context)));
  }
  if (condition(user.waka)) {
    if (widgets.length > 0) {
      widgets.add(const Divider());
    }
    widgets.add(new ListTile(
        leading: _buildIcon(images.wakatime()),
        title: new Text('Wakatime'),
        onTap: _editWakatime(context)));
  }
  return widgets;
}

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPage createState() => new _AccountsPage();
}

class _AccountsPage extends UserState<AccountsPage> {
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

class __AddAccountPage extends UserState<_AddAccountPage> {
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
