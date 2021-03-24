import 'package:flutter/material.dart';

enum TabItem { home, projects, calendar, users, settings }

Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.projects: 'Projects',
  TabItem.calendar: 'Calendar',
  TabItem.users: 'Users',
  TabItem.settings: 'Settings',
};

Map<TabItem, IconData> tabIcon = {
  TabItem.home: Icons.home,
  TabItem.projects: Icons.list,
  TabItem.calendar: Icons.calendar_today,
  TabItem.users: Icons.people,
  TabItem.settings: Icons.settings
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.blue, //Colors.red,
  TabItem.projects: Colors.blue, //Colors.green,
  TabItem.calendar: Colors.blue,
  TabItem.users: Colors.blue,
  TabItem.settings: Colors.blue, //Colors.amber,
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
        _buildItem(context, tabItem: TabItem.home),
        _buildItem(context, tabItem: TabItem.projects),
        _buildItem(context, tabItem: TabItem.calendar),
        _buildItem(context, tabItem: TabItem.users),
        _buildItem(context, tabItem: TabItem.settings)
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(BuildContext context, {TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = tabIcon[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(context, item: tabItem),
      ),
      // label: text,

      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(context, item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching(BuildContext context, {TabItem item}) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}
