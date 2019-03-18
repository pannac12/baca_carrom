import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'news_widget.dart';
import 'tips_widget.dart';
import 'me_widget.dart';
import 'app_data.dart';

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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget page(){
    return _children[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = AppData();
    appData.getPlayerId().then((String result) {
      AppData.playerId = result;
    });

    return MaterialApp(
        title: 'BACA Carrom',
        home: Scaffold(
          appBar: AppBar(
            title: Text('BACA Carrom'),
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
    );
  }
}