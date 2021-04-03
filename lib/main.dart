import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/projects/projects_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/bloc/timeentries/timeentries_bloc.dart';
import 'package:pm_flutter/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // THIS WORKS, just don't create the key thing in the build method
  //var asd = GlobalKey<NavigatorState>(debugLabel: 'MAIN');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UsersBloc>(
          create: (_) => UsersBloc(),
          dispose: (_, usersBloc) => usersBloc.dispose(),
        ),
        Provider<ProjectsBloc>(
          create: (_) => ProjectsBloc(),
          dispose: (_, projectsBloc) => projectsBloc.dispose(),
        ),
        Provider<TimeEntriesBloc>(
          create: (_) => TimeEntriesBloc(),
          dispose: (_, worktimesBloc) => worktimesBloc.dispose(),
        ),
        Provider<ProfileBloc>(
          create: (_) => ProfileBloc(),
          lazy: false,
          dispose: (_, profileBloc) => profileBloc.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'pm_flutter',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   accentColor: Colors.blue,
        // ),
        supportedLocales: [
          Locale('hu', 'HU'),
          Locale('en', 'US'),
        ],
        //      locale: Locale('hu'),
        localizationsDelegates: [
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list
          return supportedLocales.first;
        },
        home: LoginScreen(),
        // navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'MAIN'),
        // DON'T DO THIS, hot reload wont work (app always returns to login screen on hot reload)
      ),
    );
  }
}
