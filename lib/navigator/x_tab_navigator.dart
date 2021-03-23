import 'package:flutter/material.dart';
import 'package:pm_flutter/navigator/bottom_navigation.dart';
import 'package:pm_flutter/screens/tmp.dart';

///
///    TODO:   delete this, no longer need it
///
///

// class TabNavigatorRoutes {
//   static const String root = '/';
//   static const String detail = '/detail';
// }

// class TabNavigator extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorKey;
//   final TabItem tabItem;
//   final Function screen;

//   TabNavigator({this.navigatorKey, this.tabItem, this.screen});

//   // void _push(BuildContext context, {int materialIndex: 500}) {
//   //   var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
//   //     ),
//   //   );
//   // }

//   Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
//       {int materialIndex: 500}) {
//     return {
//       TabNavigatorRoutes.root: (context) => TMPScreen(),
//       // ColorsListPage(
//       //       color: activeTabColor[tabItem],
//       //       title: tabName[tabItem],
//       //       onPush: (materialIndex) =>
//       //           _push(context, materialIndex: materialIndex),
//       //     ),
//       TabNavigatorRoutes.detail: (context) => TMPScreen(),
//       // ColorDetailPage(
//       //       color: activeTabColor[tabItem],
//       //       title: tabName[tabItem],
//       //       materialIndex: materialIndex,
//       //     ),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     final routeBuilders = _routeBuilders(context);
//     return Navigator(
//       key: navigatorKey,
//       // initialRoute: TabNavigatorRoutes.root,
//       onGenerateRoute: (routeSettings) {
//         return MaterialPageRoute(
//           builder: (context) => screen(context),
//           // builder: (context) => routeBuilders[routeSettings.name](context),
//         );
//       },
//     );
//   }
// }
