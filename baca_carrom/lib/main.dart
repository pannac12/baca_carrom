// Author: Panna Chowdhury (pannac@gmail.com)
// [On behalf of Bay Area Carrom Association]

import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'news_widget.dart';
import 'tips_widget.dart';
import 'me_widget.dart';
import 'app_data.dart';
import 'settings.dart';
import 'feedback.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeWidget(),
    NewsWidget(),
    TipsWidget(),
    MeWidget(),
  ];

  static const String TermsOfService = 'Terms Of Service';
  static const String PrivacyPolicy = 'Privacy Policy';
  static const String AboutBaca = 'About BACA';

  static const String _urlTermsOfService = "https://bayareacarromassociation.org/ratings";
  static const String _urlPrivacyPolicy = "https://bayareacarromassociation.org/tournaments";
  static const String _urlAboutBaca = "https://bayareacarromassociation.org/about-us";

  List<String> _menuChoices = <String>[
    TermsOfService,
    PrivacyPolicy,
    AboutBaca,
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget page() {
    return _children[_currentIndex];
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void menuChoiceAction(String menuChoice) {
    if(menuChoice == TermsOfService){
      _launchURL(_urlTermsOfService);
    } else if(menuChoice == PrivacyPolicy){
      _launchURL(_urlPrivacyPolicy);
    } else if(menuChoice == AboutBaca){
      _launchURL(_urlAboutBaca);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = AppData();
    appData.getPlayerId().then((String result) {
      AppData.playerId = result;
    });

    return MaterialApp(
        title: 'BACA Carrom',
        routes: <String, WidgetBuilder>{
          '/settings': (BuildContext context) => new SettingsWidget(),
          '/feedback': (BuildContext context) => new FeedbackWidget(),
          '/home': (BuildContext context) => new HomeWidget(),
        },
        home: Builder(
        builder: (context) =>Scaffold(
          appBar: AppBar(
            title: Text('BACA Carrom', textAlign: TextAlign.center),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: menuChoiceAction,
                itemBuilder: (BuildContext context) {
                  return _menuChoices.map((String menuChoice) {
                    return PopupMenuItem<String>(
                      value: menuChoice,
                      child: Text(menuChoice),
                    );
                  }).toList();
                },
              )
            ],
          ),
          drawer: new Drawer(
              child: new ListView(
                children: <Widget>[
                  new ListTile(
                    title: new Text('Submit Feedback'),
                    onTap: () {
                      Navigator.of(context).pushNamed('/feedback');
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: new Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pushNamed('/settings');
                    },
                  ),
                  Divider(),
                ],
              )
          ),
          body: page(), // new
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.announcement),
                title: Text('News'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.center_focus_strong),
                title: Text('Tips'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Me')
              )
            ],
          ),
        )
    )
    );}
}



