import 'package:flutter/material.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/screens/leaves.dart';
import 'package:pm_flutter/screens/login_screen.dart';
import 'package:pm_flutter/screens/tmp.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final Function pushReplacement;

  ProfileScreen(this.pushReplacement);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate(Strings.profileTab))),
      body: StreamBuilder<User>(
          stream: _profileBloc.profile,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('Beállítások'),
                    ),
                    onTap: () => {},
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(AppLocalizations.of(context).translate(Strings.leaves)),
                    ),
                    onTap: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => LeavesScreen()),
                      )
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text("Kijelentkezés"),
                    ),
                    onTap: _onLogout,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _onLogout() async {
    await _profileBloc.logout();

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
