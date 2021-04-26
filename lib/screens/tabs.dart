import 'package:flutter/material.dart';
import 'package:pm_flutter/navigator/bottom_navigation.dart';
import 'package:pm_flutter/screens/calendar/calendar.dart';
import 'package:pm_flutter/screens/home/home.dart';
import 'package:pm_flutter/screens/projects/project_list.dart';
import 'package:pm_flutter/screens/settings.dart';
import 'package:pm_flutter/screens/tmp.dart';
import 'package:pm_flutter/screens/users/user_list.dart';

class TabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen> {
  TabItem _currentTab = TabItem.home;
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    // not sure what this debugLabel does, or how to access it
    TabItem.home: GlobalKey<NavigatorState>(debugLabel: 'HOME_TAB'),
    TabItem.projects: GlobalKey<NavigatorState>(debugLabel: 'PROJECTS_TAB'),
    TabItem.calendar: GlobalKey<NavigatorState>(debugLabel: 'CALENDAR_TAB'),
    TabItem.users: GlobalKey<NavigatorState>(debugLabel: 'USERS_TAB'),
    TabItem.profile: GlobalKey<NavigatorState>(debugLabel: 'PROFILE_TAB'),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.projects),
          _buildOffstageNavigator(TabItem.calendar),
          _buildOffstageNavigator(TabItem.users),
          _buildOffstageNavigator(TabItem.profile),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem, child: _renderTab(tabItem),
      // TabNavigator(
      //   navigatorKey: _navigatorKeys[tabItem],
      //   tabItem: tabItem,
      // ),
    );
  }

  Widget _renderTab(TabItem tabItem) {
    return Navigator(
      key: _navigatorKeys[tabItem],
      // initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (tabItem) {
              case TabItem.home:
                return HomeScreen();
              case TabItem.projects:
                return ProjectListScreen();
              case TabItem.calendar:
                return CalendarScreen();
              case TabItem.users:
                return UserListScreen();
              case TabItem.profile:
                return ProfileScreen(_pushReplacement);
              //   must pass this to settigsScreen (this context is needed to pop the screens correctly at logout)
              default:
                return TMPScreen();
            }
          },
          // builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }

  void _pushReplacement(MaterialPageRoute route) {
    Navigator.of(context).pushReplacement(route);
  }
}
