import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './user_state.dart';
import '../widgets/loading_screen.dart';
import '../widgets/form/password.dart';

typedef void ChangeListener(String data);

class FormProperty<T> {
  final Key fieldKey;
  FormFieldValidator<String> validator;
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
      this.validator,
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

abstract class UserConfigurationPage<T extends StatefulWidget>
    extends UserState<T> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _title;
  @protected
  final List<FormProperty> formProperties = new List<FormProperty>();

  UserConfigurationPage(this._title);

  @protected
  bool hasPreviousValue();
  @protected
  void deleteAccount() {
    Navigator.pop(context, user);
  }

  @protected
  void setToUser();

  void _deleteAccount() {
    () async {
      final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('Delete $_title'),
              content:
                  const Text('Are you sure you want to delete this account'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                new FlatButton(
                  child: new Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });
      if (shouldDelete) {
        deleteAccount();
      }
    }();
  }

  List<Widget> _formButtons() {
    List<Widget> buttons = new List<Widget>();
    final saveButton = new RaisedButton(
      color: Colors.blue,
      child: new Text(
        'Save',
      ),
      onPressed: _submit,
    );
    if (hasPreviousValue()) {
      buttons.add(new RaisedButton(
        color: new Color.fromARGB(1, 239, 83, 80),
        child: new Text(
          'Delete',
        ),
        onPressed: _deleteAccount,
      ));
    }
    buttons.add(saveButton);
    return buttons;
  }

  List<Widget> _buildFormWidgets() {
    List<Widget> widgets = new List<Widget>();
    this.formProperties.forEach((p) {
      Widget field;
      if (p.isPassword) {
        field = new PasswordFormField(
          fieldKey: p.fieldKey,
          hintText: p.name,
          onSaved: p.onChange,
        );
      } else {
        field = new TextFormField(
          autocorrect: false,
          keyboardType: p.keyboardType,
          initialValue: p.initialValue,
          validator: p.validator,
          decoration: new InputDecoration(hintText: p.name),
          onSaved: p.onChange,
        );
      }
      widgets.add(new ListTile(
        leading: new Icon(p.icon),
        title: field,
      ));
    });
    widgets.add(new Expanded(
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _formButtons(),
        ),
        margin: new EdgeInsets.only(bottom: 20.0),
      ),
    ));
    return widgets;
  }

  void _submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      setToUser();
      saveUser().then((Null n) {
        Navigator.pop(context, user);
      });
    }
  }

  Widget _buildForm() {
    final formWidgets = _buildFormWidgets();
    return new Container(
        child: new Form(
      key: this._formKey,
      child: new Column(children: formWidgets),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget component;
    if (initialized) {
      component = _buildForm();
    } else {
      initialize();
      component = new LoadingScreen();
    }
    return new Material(
      color: Colors.blue,
      child: new Scaffold(
          appBar: new AppBar(title: new Text(_title)), body: component),
    );
  }
}
