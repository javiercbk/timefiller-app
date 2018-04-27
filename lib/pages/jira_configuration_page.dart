import 'package:flutter/material.dart';

import './user_configuration.dart';

typedef void ChangeListener(String data);

class JiraConfigurationPage extends StatefulWidget {
  @override
  _JiraConfigurationPage createState() => new _JiraConfigurationPage();
}

class _JiraConfigurationPage
    extends UserConfigurationPage<JiraConfigurationPage> {
  _JiraConfigurationPage() : super();

  @override
  initialize() {
    controllers.add(new ControllableFormProperty(new FormProperty<String>(
        icon: Icons.home,
        name: 'Host',
        keyboardType: TextInputType.url,
        initialValue: user.jira.host,
        isPassword: false,
        onChange: (String host) {
          user.jira.host = host;
        })));
    controllers.add(new ControllableFormProperty(new FormProperty<String>.email(
        name: 'Email',
        initialValue: user.jira.username,
        onChange: (String username) {
          user.jira.username = username;
        })));
    controllers
        .add(new ControllableFormProperty(new FormProperty<String>.password(
            name: 'Password',
            onChange: (String password) {
              user.jira.password = password;
            })));
    super.initialize();
  }
}