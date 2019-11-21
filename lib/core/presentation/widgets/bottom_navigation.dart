import 'package:flutter/material.dart';

enum TabItem { lamps, groups }

Map<TabItem, String> tabNames = {
  TabItem.lamps: 'Lamps',
  TabItem.groups: 'Groups',
};

Map<TabItem, IconData> tabIcons = {
  TabItem.lamps: Icons.wb_incandescent,
  TabItem.groups: Icons.group_work,
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(context: context, tabItem: TabItem.lamps),
        _buildItem(context: context, tabItem: TabItem.groups),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({BuildContext context, TabItem tabItem}) {
    String text = tabNames[tabItem];
    IconData iconData = tabIcons[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: _colorTabMatching(context: context, item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(context: context, item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({BuildContext context, TabItem item}) {
    return currentTab == item ? Theme.of(context).accentColor : Colors.grey;
  }
}
