import 'package:flutter/material.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/screens/leaves.dart';
import 'package:pm_flutter/screens/login_screen.dart';
import 'package:pm_flutter/screens/tmp.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final Function pushReplacement;

  SettingsScreen(this.pushReplacement);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileBloc _profileBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text('Profile'),
            ),
            onTap: () => {},
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text('Leaves'),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => LeavesScreen()),
              )
            },
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Text("Logout"),
            ),
            onTap: _onLogout,
          ),
        ],
      ),
    );
  }

  void _onLogout() {
    _profileBloc.logout();

    print(Navigator.of(context).toString());

    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
        // fullscreenDialog: true,
      ),
    );

    // widget.pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //     fullscreenDialog: true,
    //   ),
    // );
  }
}
