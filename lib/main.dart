import 'package:flutter/material.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/projects/projects_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/bloc/worktimes/worktimes_bloc.dart';
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
            dispose: (_, projectsBloc) => projectsBloc.dispose()),
        Provider<WorktimesBloc>(
          create: (_) => WorktimesBloc(),
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
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.blue,
        ),
        home: LoginScreen(),
        // navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'MAIN'),
        // DON'T DO THIS, hot reload wont work (app always returns to login screen on hot reload)
      ),
    );
  }
}
