import 'package:flutter/material.dart';
import '../model/models.dart';
import './user_configuration.dart';

typedef void ChangeListener(String data);

class JiraConfigurationPage extends StatefulWidget {
  @override
  _JiraConfigurationPage createState() => new _JiraConfigurationPage();
}

class _JiraConfigurationPage
    extends UserConfigurationPage<JiraConfigurationPage> {
  _JiraConfigurationPage() : super('Jira');
  final Jira _jira = new Jira(host: '', username: '', password: '');

  @override
  onUserInitialized() {
    if (user.jira != null) {
      if (user.jira.host != null) {
        _jira.host = user.jira.host;
      }
      if (user.jira.username != null) {
        _jira.username = user.jira.username;
      }
    }
  }

  @override
  setToUser() {
    if (user.jira == null) {
      user.jira = new Jira();
    }
    user.jira.host = _jira.host;
    user.jira.username = _jira.username;
    if (user.jira.password == null || _jira.password.length > 0) {
      user.jira.password = _jira.password;
    }
  }

  @override
  void deleteAccount() {
    user.jira = null;
    saveUser();
    super.deleteAccount();
  }

  bool hasPreviousValue() {
    return user.jira != null;
  }

  @override
  initialize() {
    formProperties.add(new FormProperty<String>(
        icon: Icons.home,
        name: 'Host',
        keyboardType: TextInputType.url,
        initialValue: _jira.host,
        isPassword: false,
        onChange: (String host) {
          _jira.host = host;
        }));
    formProperties.add(new FormProperty<String>.email(
        name: 'Email',
        initialValue: _jira.username,
        onChange: (String username) {
          _jira.username = username;
        }));
    formProperties.add(new FormProperty<String>.password(
        name: 'Password',
        onChange: (String password) {
          _jira.password = password;
        }));
    super.initialize();
  }
}
