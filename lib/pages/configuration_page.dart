import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './jira_configuration_page.dart';
import './harvest_configuration_page.dart';
import './waka_configuration_page.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('Configuration')),
        body: new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Stack(
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.expand,
              children: [
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    new Padding(
                        padding: new EdgeInsets.only(bottom: 10.0),
                        child: new RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new JiraConfigurationPage()),
                              );
                            },
                            child: new Text('Jira'))),
                    new Padding(
                        padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: new RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new HarvestConfigurationPage()),
                              );
                            },
                            child: new Text('Harvest'))),
                    new Padding(
                        padding: new EdgeInsets.only(top: 10.0),
                        child: new RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new WakaConfigurationPage()),
                              );
                            },
                            child: new Text('WakaTime')))
                  ],
                )
              ],
            )));
  }
}
