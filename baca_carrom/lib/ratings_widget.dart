// Author: Panna Chowdhury (pannac@gmail.com)
// [On behalf of Bay Area Carrom Association]

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_data.dart';

class RatingsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RatingsWidgetState();
  }
}

class _RatingsWidgetState extends State<RatingsWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('ratings').where("id", isEqualTo: AppData.playerId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        return _getData(context, snapshot.data.documents);
      },
    );
  }

  Widget _getData(BuildContext context, List<DocumentSnapshot> snapshot) {
    String name = "";
    int rank = 0;
    int rating = 0;
    if (snapshot.length>0){
      name = snapshot[0].data['name'];
      AppData.playerName = name;
      rank = snapshot[0].data['rank'];
      rating = snapshot[0].data['rating'];
    }
    return Column(
      children: <Widget>[
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("My name: "),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("My BACA rating: "),
            Text(rating.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("My BACA rank: "),
              Text(rank.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
      ],
    );
  }

}