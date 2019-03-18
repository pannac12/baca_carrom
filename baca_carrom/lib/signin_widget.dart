import 'package:flutter/material.dart';
import 'app_data.dart';

class SignInWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInWidgetState();
  }
}

class _SignInWidgetState extends State<SignInWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _playerId = "";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              print(value);
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                _playerId = value;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(_playerId)));
                  AppData appData = AppData();
                  appData.setPlayerId(_playerId);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

}