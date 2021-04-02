import 'package:flutter/material.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/screens/users/admin_worktimes.dart';
import 'package:pm_flutter/screens/users/user_details.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UsersBloc _usersBloc;
  ProfileBloc _profileBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
    }
    if (_usersBloc == null) {
      _usersBloc = Provider.of<UsersBloc>(context);
    }
    //if (_profileBloc.isAdmin) {
    _usersBloc.getUsersList(_profileBloc.isAdmin);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(hintText: "Find User"),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _userList(),
          )
        ],
      ),
    );
  }

  Widget _userList() {
    return Container(
      child: StreamBuilder<List<User>>(
        stream: _usersBloc.users,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("Something went wrong!\n${snapshot.error.toString()}"),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => ListTile(
                onTap: () => _openUserDetails(context, snapshot.data[i]),
                title: Text(
                  _profileBloc.userId == snapshot.data[i].id
                      ? '${snapshot.data[i].name} *'
                      : snapshot.data[i].name,
                ),
              ),
              separatorBuilder: (context, i) =>
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _openUserDetails(BuildContext context, User user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetailsScreen(user)));
  }
}

/*

 Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text("List All Worktimes"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminWorktimesScreen()));
                    },
                  ),
                ),

*/
