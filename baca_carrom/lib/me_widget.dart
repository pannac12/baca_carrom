import 'package:flutter/material.dart';
import 'player_widget.dart';
import 'tournament_widget.dart';
import 'signin_widget.dart';
import 'app_data.dart';

class MeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MeWidgetState();
  }
}

class _MeWidgetState extends State<MeWidget> {
  @override
  Widget build(BuildContext context) {
    if (AppData.playerId == "")
      return SignInWidget();
    else return Column(
      children: <Widget>[
        PlayerWidget(),
        TournamentWidget()
      ],
    );
  }

}
