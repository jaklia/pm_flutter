import 'package:flutter/material.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/constants/localization.dart';

enum TabItem { home, projects, calendar, users, profile }

Map<TabItem, String> tabName = {
  TabItem.home: Strings.homeTab,
  TabItem.projects: Strings.projectsTab,
  TabItem.calendar: Strings.calendarTab,
  TabItem.users: Strings.usersTab,
  TabItem.profile: Strings.profileTab,
};

Map<TabItem, IconData> tabIcon = {
  TabItem.home: Icons.home,
  TabItem.projects: Icons.list,
  TabItem.calendar: Icons.calendar_today,
  TabItem.users: Icons.group,
  TabItem.profile: Icons.person,
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.blue, //Colors.red,
  TabItem.projects: Colors.blue, //Colors.green,
  TabItem.calendar: Colors.blue,
  TabItem.users: Colors.blue,
  TabItem.profile: Colors.blue, //Colors.amber,
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
        _buildItem(context, tabItem: TabItem.profile)
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(BuildContext context, {TabItem tabItem}) {
    String text = AppLocalizations.of(context).translate(tabName[tabItem]);
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
