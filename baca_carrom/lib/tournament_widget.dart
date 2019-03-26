// Author: Panna Chowdhury (pannac@gmail.com)
// [On behalf of Bay Area Carrom Association]

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_data.dart';

class TournamentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TournamentWidgetState();
  }
}

class _TournamentWidgetState extends State<TournamentWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tournament').where(
          "id", isEqualTo: AppData.playerId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        return _getData(context, snapshot.data.documents);
      },
    );
  }

  Widget _getData(BuildContext context, List<DocumentSnapshot> snapshot) {
    String tournament = "";
    String lastOpponent = "";
    String lastScore = "";
    String nextOpponent = "";
    String nextBoard = "";
    String startTime = "";
    if (snapshot.length > 0) {
      tournament = snapshot[0].data['tournament'];
      lastOpponent = snapshot[0].data['last_opponent'];
      nextOpponent = snapshot[0].data['next_opponent'];
      lastScore = snapshot[0].data['last_score'];
      nextBoard = snapshot[0].data['next_board'];
      startTime = snapshot[0].data['start_time'];
    }
    return Column(
      children: <Widget>[
        Divider(),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Tournament: "),
              Text(tournament, style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Next Opponent: "),
              Text(nextOpponent, style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Next Board: "),
              Text(nextBoard, style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Start Time: "),
              Text(startTime, style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        Divider(),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Last Opponent: "),
              Text(lastOpponent, style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Last Score: "),
              Text(lastScore, style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
      ],
    );
  }

}