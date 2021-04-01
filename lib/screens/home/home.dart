import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/timeentries/timeentries_bloc.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:pm_flutter/screens/projects/log_worktime.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _from, _to;
  TimeEntriesBloc _worktimesBloc;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _from = DateTime.now().subtract(Duration(days: 3));
    _to = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_worktimesBloc == null) {
      _worktimesBloc = Provider.of<TimeEntriesBloc>(context);
    }
    _worktimesBloc.getWorktimes(_from, _to);
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User>(
          stream: _profileBloc.profile,
          builder: (context, snapshot) =>
              snapshot.hasData ? Text(snapshot.data.name) : Text("User"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _header(),
          Expanded(
            child: StreamBuilder<List<TimeEntry>>(
              stream: _worktimesBloc.worktimes,
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
                      onTap: () => _editWorktime(context, snapshot.data[i]),
                      title: Text(
                        "${DateFormat("y.MM.d").format(snapshot.data[i].date)}  ${snapshot.data[i].issueName}",
                      ),
                      subtitle: Text(
                        "${snapshot.data[i].minutes / 60.0} hours ${snapshot.data[i].description}",
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        color: Colors.red,
                        onPressed: () => _deleteWorktime(snapshot.data[i]),
                      ),
                    ),
                    separatorBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16), child: Divider()),
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

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: _fromDate,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "From ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2 // body1
                      .copyWith(color: Colors.grey),
                ),
                Text(
                  DateFormat("y.MM.d").format(_from),
                  style: Theme.of(context).textTheme.bodyText2, //body1,
                ),
              ],
            ),
          ),
        ),
        //SizedBox(width: 40),
        InkWell(
          onTap: _toDate,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "To ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2 //body1
                      .copyWith(color: Colors.grey),
                ),
                Text(
                  DateFormat("y.MM.d").format(_to),
                  style: Theme.of(context).textTheme.bodyText2, //body1,
                ),
              ],
            ),
          ),
        ),
        TextButton(
          child: Text("OK"),
          onPressed: _filterDate,
        )
      ],
    );
  }

  void _deleteWorktime(TimeEntry wt) {
    _worktimesBloc.deleteWorktime(wt);
    _worktimesBloc.getWorktimes(_from, _to);
  }

  void _editWorktime(BuildContext context, TimeEntry wt) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LogWorkTimeScreen(
          worktime: wt,
        ),
      ),
    );
  }

  void _fromDate() async {
    var res = await _openDatePicker(_from);
    if (res != null) {
      setState(() {
        _from = res;
      });
    }
  }

  void _toDate() async {
    var res = await _openDatePicker(_to);
    if (res != null) {
      setState(() {
        _to = res;
      });
    }
  }

  bool _checkDate(DateTime from, DateTime to) {
    return from.isBefore(to);
  }

  void _showDialog({String title = "", String text = ""}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _filterDate() {
    if (_checkDate(_from, _to)) {
      _worktimesBloc.filter(_from, _to);
    } else {
      _showDialog(title: "The from date must be before to");
    }
  }

  Future<DateTime> _openDatePicker(DateTime date) async {
    return showDatePicker(
      context: context,
      initialDate: date,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 20)),
      lastDate: DateTime.now().add(Duration(days: 1)),
    );
  }
}
