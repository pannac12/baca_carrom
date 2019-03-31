// Author: Panna Chowdhury (pannac@gmail.com)
// [On behalf of Bay Area Carrom Association]

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_data.dart';

class SubmitScoreWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubmitScoreState();
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Score submitted'),
        content: const Text('Thank you!'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _navHome(BuildContext context) {
  Navigator.pop(context);
}

void submitScore(String player1, String score1, String player2, String score2) {
  CollectionReference collection = Firestore.instance.collection('scores');
  DateTime now = DateTime.now();
  Map<String, dynamic> data = {
    'date': now.toString(),
    'player1': player1,
    'score1': score1,
    'player2': player2,
    'score2': score2,
  };
  collection.add(data).whenComplete(() {});
}

class _SubmitScoreState extends State<SubmitScoreWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> _dropDownPlayers;
  String _currentPlayer;

  List<DropdownMenuItem<String>> _dropDownScore1;
  String _currentScore1;

  List<DropdownMenuItem<String>> _dropDownScore2;
  String _currentScore2;

  void changedDropDownPlayers(String selectedPlayer) {
    setState(() {
      _currentPlayer = selectedPlayer;
    });
  }

  void changedDropDownScore1(String selectedScore1) {
    setState(() {
      _currentScore1 = selectedScore1;
    });
  }

  void changedDropDownScore2(String selectedScore2) {
    setState(() {
      _currentScore2 = selectedScore2;
    });
  }

  @override
  void initState() {
    _currentScore1 = "0";
    _dropDownScore1 = new List();
    for (int i = 0; i <= 25; i++) {
      _dropDownScore1.add(new DropdownMenuItem(
          value: i.toString(), child: new Text(i.toString())));
    }

    _currentScore2 = "0";
    _dropDownScore2 = new List();
    for (int i = 0; i <= 25; i++) {
      _dropDownScore2.add(new DropdownMenuItem(
          value: i.toString(), child: new Text(i.toString())));
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('players').orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _getData(context, snapshot.data.documents);
      },
    );
  }

  Widget _getData(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<String> players = new List();
    if (snapshot.length > 0) {
      for (int i = 0; i < snapshot.length; i++) {
        players.add(snapshot[i].data['name']);
      }
    }

    _dropDownPlayers = new List();
    for (String player in players) {
      _dropDownPlayers
          .add(new DropdownMenuItem(value: player, child: new Text(player)));
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Scores'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: DropdownButton(
                        value: _currentScore1,
                        items: _dropDownScore1,
                        onChanged: changedDropDownScore1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 6.0),
                      child: Text(AppData.playerName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  new Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 16.0),
                      child: DropdownButton(
                        value: _currentScore2,
                        items: _dropDownScore2,
                        onChanged: changedDropDownScore2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 6.0),
                      child: DropdownButton(
                        value: _currentPlayer,
                        items: _dropDownPlayers,
                        onChanged: changedDropDownPlayers,
                      ),
                    ),
                  ]),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              submitScore(AppData.playerName, _currentScore1,
                                  _currentPlayer, _currentScore2);
                              _ackAlert(context);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          onPressed: () => _navHome(context),
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ])));
  }
}
