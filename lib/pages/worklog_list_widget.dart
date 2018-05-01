import 'dart:async';
import 'package:flutter/material.dart';
import '../storage/timefiller_storage.dart';
import '../model/models.dart';

class WorklogListWidget extends StatefulWidget {
  @override
  _WorklogListState createState() => new _WorklogListState();
}

class _WorklogListState extends State<WorklogListWidget> {
  final EntityStorage<List<Worklog>> _worklogStorage = worklogStorage;
  List<Worklog> worklogs;

  Future<Null> getSharedPrefs() async {
    final worklogsFromFile = await this._worklogStorage.read;
    if (worklogsFromFile != null) {
      setState(() {
        worklogs = worklogsFromFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.grey,
        child: new Row(children: [
          new Expanded(
              child: new ListTile(
                  leading: const Icon(Icons.hourglass_empty),
                  title: new Text("No worklogs recorded")))
        ]));
  }
}
