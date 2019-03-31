// Author: Panna Chowdhury (pannac@gmail.com)
// [On behalf of Bay Area Carrom Association]

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedbackState();
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Feedback submitted'),
        content: const Text('Thank you for your feedback!'),
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

void submitFeedback(String name, String text) {
  CollectionReference collection = Firestore.instance.collection('feedback');
  DateTime now = DateTime.now();
  Map<String, dynamic> data = {
    'date': now.toString(),
    'name': name,
    'text': text,
  };
  collection.add(data).whenComplete(() {});
}

class _FeedbackState extends State<FeedbackWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Feedback'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      labelText: 'Your name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        _name = value;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      labelText: 'Your feedback',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        _text = value;
                      }
                    },
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              submitFeedback(_name, _text);
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
