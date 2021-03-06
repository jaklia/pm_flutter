import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/worktimes/worktimes_bloc.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/worktime.dart';
import 'package:provider/provider.dart';

class LogWorkTimeScreen extends StatefulWidget {
  final Issue issue;
  final WorkTime worktime;

  LogWorkTimeScreen({this.issue, this.worktime});

  @override
  _LogWorkTimeScreenState createState() => _LogWorkTimeScreenState();
}

class _LogWorkTimeScreenState extends State<LogWorkTimeScreen> {
  DateTime _date;
  int _hours;
  WorktimesBloc _worktimesBloc;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _date = widget.worktime == null ? DateTime.now() : widget.worktime.date;
    _hours = widget.worktime == null ? null : widget.worktime.duration;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_worktimesBloc == null) {
      _worktimesBloc = Provider.of<WorktimesBloc>(context);
    }
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _header(),
            SizedBox(height: 20),
            _dateInput(),
            SizedBox(height: 20),
            _wortimeInput(),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Save"),
                onPressed: () => _save(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   "project name",
        //   style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
        // ),
        SizedBox(height: 10),
        Text(
          widget.worktime == null
              ? widget.issue.name
              : widget.worktime.issueName,
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 20),
        // Text(widget.issue.description,
        //     style: Theme.of(context).textTheme.body1),
      ],
    );
  }

  Widget _dateInput() {
    return InkWell(
      onTap: _openDatePicker,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Date',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.grey),
            ),
            Text(
              DateFormat.MMMMEEEEd().format(_date),
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _wortimeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Worktime',
          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
        ),
        SizedBox(width: 120),
        Container(
          width: 50,
          child: TextFormField(
            decoration: InputDecoration(hintText: "8"),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            initialValue: (_hours == null ? "" : _hours.toString()),
            onFieldSubmitted: (text) {
              setState(() {
                _hours = int.parse(text);
              });
            },
          ),
        ),
      ],
    );
  }

  void _save(BuildContext context) async {
    // TODO:     user / userId,    issue / issueId  ????
    print("${_date.toString()}  -  $_hours");
    if (widget.worktime == null) {
      var res = await _worktimesBloc.addWorktime(
        WorkTime(
          id: 0,
          duration: _hours,
          date: _date,
          issueId: widget.issue.id,
          userId: _profileBloc.userId,
          issueName: widget.issue.name,
        ),
      );
    } else {
      var res = await _worktimesBloc.editWorktime(
        WorkTime(
          id: widget.worktime.id,
          duration: _hours,
          date: _date,
          issueId: widget.worktime.issueId,
          userId: _profileBloc.userId,
          issueName: widget.worktime.issueName,
        ),
      );
    }
    // TODO:   if success:
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text("success"),
    // ));
    Navigator.of(context).pop();
  }

  void _openDatePicker() async {
    var res = await showDatePicker(
      context: context,
      initialDate: _date,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now().subtract(Duration(days: DateTime.now().day)),
      lastDate: DateTime.now(),
    );
    if (res != null) {
      setState(() {
        _date = res;
      });
    }
  }
}
