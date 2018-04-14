import 'dart:async';
import 'package:flutter/material.dart';
import '../storage/timefiller_storage.dart';
import '../model/models.dart';

abstract class UserState<T extends StatefulWidget> extends State<T> {
  final EntityStorage<User> _userStorage = userStorage;
  User user = new User();

  Future<Null> getSharedPrefs() async {
    final userFromFile = await this._userStorage.read;
    if (userFromFile != null) {
      setState(() {
        user = userFromFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }
}
