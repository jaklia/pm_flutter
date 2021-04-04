import 'package:flutter/material.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/meeting/meeting_bloc.dart';
import 'package:pm_flutter/helper/date.dart';
import 'package:pm_flutter/models/meeting.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  MeetingsBloc _meetingsBloc;
  DateTime _date;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _date = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_meetingsBloc == null) {
      _meetingsBloc = Provider.of<MeetingsBloc>(context);
    }
    _meetingsBloc.getMeetings();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            locale: AppLocalizations.of(context).locale.languageCode,
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (day, events, holidays) => setState(() {
              _date = day.onlyDate();
            }),
            events: _meetingsBloc.meetingMap ?? {},
            holidays: {
              DateTime(2021, 4, 22): ["e1"],
              DateTime(2021, 4, 23): ["e1"],
            },
          ),
          // SizedBox(height: 20),
          StreamBuilder<List<Meeting>>(
              stream: _meetingsBloc.meetings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var a = _meetingsBloc.meetingMap[_date]?.length ?? 0;
                  if (a == 0) {
                    return Text("no meeting today");
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: _meetingsBloc.meetingMap[_date].length,
                        itemBuilder: (context, idx) {
                          var m = _meetingsBloc.meetingMap[_date][idx];
                          return ListTile(
                            title: Text(m.title ?? "(had no title)"),
                          );
                        },
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("asd");
                } else {
                  return Container();
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}
