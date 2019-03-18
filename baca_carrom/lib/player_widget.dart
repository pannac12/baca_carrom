import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_data.dart';

class PlayerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('players').where("id", isEqualTo: AppData.playerId).snapshots(),
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
      rank = snapshot[0].data['rank'];
      rating = snapshot[0].data['rating'];
    }
    return new Column(
      children: <Widget>[
          Divider(),
          Text("My name: " + name),
          Divider(),
          Text("My BACA rating: " + rating.toString()),
          Divider(),
          Text("My BACA rank: "+ rank.toString()),
          Divider()
      ],
    );
  }

}