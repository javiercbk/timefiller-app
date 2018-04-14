import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './user_state.dart';
import '../widgets/form/password.dart';

class JiraConfigurationPage extends StatefulWidget {
  @override
  _JiraConfigurationPage createState() => new _JiraConfigurationPage();
}

class _JiraConfigurationPage extends UserState<JiraConfigurationPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();

  _hostChanged(String host) {
    setState(() {
      user.jira.host = host;
    });
  }

  _usernameChanged(String username) {
    setState(() {
      user.jira.username = username;
    });
  }

  _passwordChanged(String password) {
    setState(() {
      user.jira.password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blue,
      child: new Scaffold(
        appBar: new AppBar(title: const Text('Jira')),
        body: new Form(
            key: _formKey,
            child: new SingleChildScrollView(
                child: new Column(children: [
              new ListTile(
                leading: const Icon(Icons.home),
                title: new TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.url,
                  onSaved: _hostChanged,
                  initialValue: user.jira.host,
                  decoration: new InputDecoration(
                    hintText: "Host",
                  ),
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.email), // Icons.person
                title: new TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: _usernameChanged,
                  initialValue: user.jira.username,
                  decoration: new InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.lock),
                title: new PasswordField(
                    fieldKey: _passwordFieldKey,
                    hintText: 'Password',
                    onFieldSubmitted: _passwordChanged),
              ),
            ]))),
      ),
    );
  }
}
