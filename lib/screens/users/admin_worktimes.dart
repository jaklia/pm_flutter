import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/bloc/worktimes/worktimes_bloc.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/worktime.dart';
import 'package:pm_flutter/screens/projects/log_worktime.dart';
import 'package:provider/provider.dart';

class AdminWorktimesScreen extends StatefulWidget {
  @override
  _AdminWorktimesScreenState createState() => _AdminWorktimesScreenState();
}

class _AdminWorktimesScreenState extends State<AdminWorktimesScreen> {
  UsersBloc _userBloc;
  WorktimesBloc _worktimesBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_userBloc == null) {
      _userBloc = Provider.of<UsersBloc>(context);
    }
    _userBloc.getAllWorktimes();
    if (_worktimesBloc == null) {
      _worktimesBloc = Provider.of<WorktimesBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<WorkTime>>(
              stream: _userBloc.allWorktimes,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Text(
                        "Something went wrong!\n${snapshot.error.toString()}"),
                  );
                } else if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) => ListTile(
                      onTap: () => _editWorktime(context, snapshot.data[i]),
                      title: Text(
                        "${DateFormat("y.MM.d").format(snapshot.data[i].date)}  ${snapshot.data[i].issueName}",
                      ),
                      subtitle: Text(
                        "${snapshot.data[i].duration} minutes",
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        color: Colors.red,
                        onPressed: () => _deleteWorktime(snapshot.data[i]),
                      ),
                    ),
                    separatorBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _deleteWorktime(WorkTime wt) {
    _worktimesBloc.deleteWorktime(wt);
    _userBloc.getAllWorktimes();
  }

  void _editWorktime(BuildContext context, WorkTime wt) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LogWorkTimeScreen(
          worktime: wt,
        ),
      ),
    );
  }
}
