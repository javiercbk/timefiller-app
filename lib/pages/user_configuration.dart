import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './user_state.dart';
import '../widgets/form/password.dart';

typedef void ChangeListener(String data);

class FormProperty<T> {
  final Key fieldKey;
  bool isPassword;
  IconData icon;
  String name;
  T initialValue;
  TextInputType keyboardType;
  ChangeListener onChange;

  FormProperty(
      {@required this.name,
      this.fieldKey,
      this.initialValue,
      this.onChange,
      @required this.icon,
      this.keyboardType,
      this.isPassword}) {
    if (this.keyboardType == null) {
      this.keyboardType = TextInputType.text;
    }
  }

  FormProperty.password(
      {this.fieldKey, @required this.name, this.initialValue, this.onChange}) {
    this.keyboardType = TextInputType.text;
    this.isPassword = true;
    icon = Icons.lock_outline;
  }

  FormProperty.url(
      {this.fieldKey,
      @required this.name,
      this.initialValue,
      @required this.icon,
      @required this.onChange}) {
    this.keyboardType = TextInputType.url;
    this.isPassword = false;
  }

  FormProperty.account(
      {this.fieldKey,
      @required this.name,
      this.initialValue,
      @required this.onChange}) {
    this.keyboardType = TextInputType.text;
    this.isPassword = false;
    this.icon = Icons.account_box;
  }

  FormProperty.token(
      {this.fieldKey,
      @required this.name,
      this.initialValue,
      @required this.onChange}) {
    this.keyboardType = TextInputType.text;
    this.isPassword = false;
    this.icon = Icons.lock_outline;
  }

  FormProperty.email(
      {this.fieldKey,
      @required this.name,
      this.initialValue,
      @required this.onChange}) {
    this.keyboardType = TextInputType.emailAddress;
    this.isPassword = false;
    this.icon = Icons.email;
  }
}

class ControllableFormProperty<T> {
  FormProperty<T> property;
  TextEditingController controller;
  VoidCallback listener;

  ControllableFormProperty(this.property);
}

class UserConfigurationPage<T extends StatefulWidget> extends UserState<T> {
  bool _initialized = false;
  @protected
  List<ControllableFormProperty> controllers;

  UserConfigurationPage() {
    controllers = new List<ControllableFormProperty<String>>();
  }

  @protected
  initialize() {
    controllers.forEach((c) {
      c.controller = new TextEditingController();
      c.listener = _initializeController(
          c.controller, c.property.initialValue, c.property.onChange);
    });
  }

  _controllerListenerBuilder(
      TextEditingController controller, ChangeListener func) {
    return () {
      final newText = controller.text;
      setState(() {
        func(newText);
      });
    };
  }

  VoidCallback _initializeController(
      TextEditingController controller, String data, ChangeListener listener) {
    controller.text = data;
    final controllerListener = _controllerListenerBuilder(controller, listener);
    controller.addListener(controllerListener);
    return controllerListener;
  }

  @override
  void dispose() {
    saveUser();
    controllers.forEach((c) {
      c.controller.removeListener(c.listener);
    });
    super.dispose();
  }

  List<ListTile> _buildFormWidgets() {
    return this.controllers.map((c) {
      Widget field;
      if (c.property.isPassword) {
        field = new PasswordField(
          fieldKey: c.property.fieldKey,
          hintText: c.property.name,
          onSaved: c.property.onChange,
        );
      } else {
        field = new TextField(
          autocorrect: false,
          keyboardType: c.property.keyboardType,
          controller: c.controller,
          decoration: new InputDecoration(hintText: c.property.name),
        );
      }
      return new ListTile(
        leading: new Icon(c.property.icon),
        title: field,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      initialize();
      _initialized = true;
    }
    Iterable<Widget> formWidgets = _buildFormWidgets();
    return new Material(
      color: Colors.blue,
      child: new Scaffold(
        appBar: new AppBar(title: const Text('Jira')),
        body:
            new SingleChildScrollView(child: new Column(children: formWidgets)),
      ),
    );
  }
}
