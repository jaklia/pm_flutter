import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
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
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            events: {
              DateTime(2021, 3, 18): ["e1", "e2"],
              DateTime(2021, 3, 19): ["e1"],
              DateTime(2021, 3, 26): ["e2"],
              DateTime(2021, 3, 29): ["e2"],
              DateTime(2021, 3, 30): ["e2"],
            },
            holidays: {
              DateTime(2021, 3, 22): ["e1"],
              DateTime(2021, 3, 23): ["e1"],
            },
          )
        ],
      ),
    );
  }
}
