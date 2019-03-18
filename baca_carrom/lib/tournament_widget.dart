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
      stream: Firestore.instance.collection('tournament').where("id", isEqualTo: AppData.playerId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        return _getData(context, snapshot.data.documents);
      },
    );
  }

  Widget _getData(BuildContext context, List<DocumentSnapshot> snapshot) {
    String date = "";
    String lastOpponent = "";
    String lastScore = "";
    String nextOpponent = "";
    String nextBoard = "";
    String startTime = "";
    if (snapshot.length>0){
      date = snapshot[0].data['date'];
      lastOpponent = snapshot[0].data['last_opponent'];
      lastScore = snapshot[0].data['last_score'];
      nextOpponent = snapshot[0].data['next_opponent'];
      nextBoard = snapshot[0].data['next_board'];
      startTime = snapshot[0].data['start_time'];
    }
    return new Column(
      children: <Widget>[
        Text("Tournament date: " + date),
        Divider(),
        Text("Last Opponent: " + lastOpponent),
        Divider(),
        Text("Last Score: " + lastScore),
        Divider(),
        Text("Next Opponent: " + nextOpponent),
        Divider(),
        Text("Next Board: " + nextBoard),
        Divider(),
        Text("Start Time: " + startTime),
        Divider(),
      ],
    );
  }

}