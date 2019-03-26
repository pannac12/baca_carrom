// Author: Panna Chowdhury (pannac@gmail.com)
// [On behalf of Bay Area Carrom Association]

import 'package:flutter/material.dart';

import 'app_data.dart';

class SettingsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

void _navHome(BuildContext context) {
  Navigator.pop(context);
}

class _SettingsState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Settings'),
        ),
        body: Builder(builder: (BuildContext context) {
          return new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Version number : 1.0.0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Author : Panna Chowdhury"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Organization : Bay Area Carrom Association"),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      AppData appData = AppData();
                      appData.setPlayerId("");
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Player Key cleared!")));
                    },
                    child: Text('Clear Player Key'),
                  ),
                ),
              ]);
        }));
  }
}
