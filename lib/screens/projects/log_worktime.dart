import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/timeentries/timeentries_bloc.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:provider/provider.dart';

class LogWorkTimeScreen extends StatefulWidget {
  final Issue issue;
  final TimeEntry worktime;

  LogWorkTimeScreen({this.issue, this.worktime});

  @override
  _LogWorkTimeScreenState createState() => _LogWorkTimeScreenState();
}

class _LogWorkTimeScreenState extends State<LogWorkTimeScreen> {
  DateTime _date;
  int _minutes;
  String _description;
  TimeEntriesBloc _worktimesBloc;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    if (widget.worktime == null) {
      _date = DateTime.now();
      _minutes = null;
      _description = "";
    } else {
      _date = widget.worktime.date;
      _minutes = widget.worktime.minutes;
      _description = widget.worktime.description;
    }
    // _date = widget.worktime == null ? DateTime.now() : widget.worktime.date;
    // _minutes = widget.worktime == null ? null : widget.worktime.minutes;
    // _description = widget.worktime == null ? null : widget.worktime.description;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_worktimesBloc == null) {
      _worktimesBloc = Provider.of<TimeEntriesBloc>(context);
    }
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate(Strings.logWorktime)),
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
            _descriptionInput(),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(AppLocalizations.of(context).translate(Strings.save)),
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
          widget.worktime == null ? widget.issue.subject : widget.worktime.issueName,
          style: Theme.of(context).textTheme.headline6,
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
              AppLocalizations.of(context).translate(Strings.date),
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
            ),
            Text(
              DateFormat.yMEd(
                AppLocalizations.of(context).locale.languageCode,
              ).format(_date),
              style: Theme.of(context).textTheme.bodyText2,
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
          AppLocalizations.of(context).translate(Strings.worktime),
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
        ),
        SizedBox(width: 120),
        Container(
          width: 100,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "60",
              suffix: Text(" perc"),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            initialValue: (_minutes == null ? "" : _minutes.toString()),
            onFieldSubmitted: (text) {
              setState(() {
                _minutes = int.parse(text);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _descriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).translate(Strings.description),
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
        ),
        TextFormField(
          initialValue: _description ?? "",
          onFieldSubmitted: (text) {
            setState(() {
              _description = text;
            });
          },
        ),
      ],
    );
  }

  void _save(BuildContext context) async {
    // TODO:     user / userId,    issue / issueId  ????
    print("${_date.toString()}  -  $_minutes");
    if (widget.worktime == null) {
      var res = await _worktimesBloc.addWorktime(
        TimeEntry(
          id: 0,
          minutes: _minutes,
          date: _date,
          issueId: widget.issue.id,
          userId: _profileBloc.userId,
          issueName: widget.issue.subject,
          userName: "", // don't need this now, the backend will send back the correct value
          description: _description,
        ),
      );
    } else {
      await _worktimesBloc.editWorktime(
        TimeEntry(
          id: widget.worktime.id,
          minutes: _minutes,
          date: _date,
          issueId: widget.worktime.issueId,
          userId: widget.worktime.userId,
          issueName: widget.worktime.issueName,
          userName: widget.worktime.userName,
          description: _description,
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
