import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class TipsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TipsWidgetState();
  }
}

class _TipsWidgetState extends State<TipsWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tips').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        return _getData(context, snapshot.data.documents);
      },
    );
  }

  Widget _getData(BuildContext context, List<DocumentSnapshot> snapshot) {
    return SingleChildScrollView(
      child: Center(
          child: HtmlView(data: snapshot[0].data['text'])
      ),
    );
  }

}

