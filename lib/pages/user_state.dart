import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../storage/timefiller_storage.dart';
import '../model/models.dart';

abstract class UserState<T extends StatefulWidget> extends State<T> {
  final EntityStorage<User> _userStorage = userStorage;
  @protected
  User user = new User();

  Future<Null> _getSharedPrefs() async {
    final userFromFile = await _userStorage.read;
    if (userFromFile != null) {
      setState(() {
        user = userFromFile;
      });
    }
  }

  @protected
  Future<Null> saveUser() async {
    await _userStorage.write(user);
  }

  @override
  void initState() {
    super.initState();
    _getSharedPrefs();
  }
}
