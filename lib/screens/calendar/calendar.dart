import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/meeting/meeting_bloc.dart';
import 'package:pm_flutter/components/edit_meeting_dialog.dart';
import 'package:pm_flutter/constants/localization.dart';
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate(Strings.calendarTab)),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: CalendarStyle(
              markersMaxAmount: 3,
            ),
            availableCalendarFormats: {
              CalendarFormat.month: 'Month',
            },
            locale: AppLocalizations.of(context).locale.languageCode,
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (day, events, holidays) => setState(() {
              _date = day.onlyDate();
            }),
            events: _meetingsBloc.meetingMap ?? {},
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
                    return renderList();
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
        onPressed: () => showDialog(
          context: context,
          builder: (_) => EditMeetingDialog(),
        ),
      ),
    );
  }

  Flexible renderList() {
    return Flexible(
      child: ListView.builder(
        //shrinkWrap: true,
        itemCount: _meetingsBloc.meetingMap[_date].length,
        itemBuilder: (context, idx) {
          var m = _meetingsBloc.meetingMap[_date][idx];
          return renderMeeting(context, m);
        },
      ),
    );
  }

  Card renderMeeting(BuildContext context, Meeting m) {
    var from = DateFormat.Hm(
      AppLocalizations.of(context).locale.languageCode,
    ).format(m.startDate);
    var to = DateFormat.Hm(
      AppLocalizations.of(context).locale.languageCode,
    ).format(m.endDate);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '$from - $to',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(width: 10),
                Text(
                  m.title ?? "(had no title)",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            SizedBox(height: 10),
            //Divider(),
            Row(
              children: [
                SizedBox(width: 40),
                Icon(
                  Icons.meeting_room,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(width: 4),
                Text(
                  m.room.name,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.group,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(width: 4),
                Text(
                  m.userIds.length.toString(),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
