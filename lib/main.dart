import 'package:bottom_nav_bar/core/presentation/widgets/bottom_navigation.dart';
import 'package:bottom_nav_bar/tab_navigator.dart';
import 'package:flutter/material.dart';

import 'color_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bottom Navigation App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TabItem _currentTab = TabItem.lamps;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.lamps: GlobalKey<NavigatorState>(),
    TabItem.groups: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: Scaffold(
          /*appBar: AppBar(
          title: Text(widget.title),
        ),*/
          body: Stack(
            children: <Widget>[
              _buildOffstageNavigator(TabItem.lamps),
              _buildOffstageNavigator(TabItem.groups),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          )),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
        offstage: _currentTab != tabItem,
        child: TabNavigator(
          navigatorKey: navigatorKeys[tabItem],
          tabItem: tabItem,
        ));
  }
}
