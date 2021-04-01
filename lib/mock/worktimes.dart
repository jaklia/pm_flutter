import 'package:pm_flutter/models/timeentry.dart';

List<TimeEntry> worktimes = [
  TimeEntry(id: 1, date: DateTime.now(), minutes: 8, issueId: 11, userId: 1, issueName: "Issue 11"),
  TimeEntry(
      id: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
      minutes: 8,
      issueId: 11,
      userId: 1,
      issueName: "Issue 11"),
  TimeEntry(
      id: 1,
      date: DateTime.now().subtract(Duration(days: 2)),
      minutes: 8,
      issueId: 11,
      userId: 2,
      issueName: "Issue 11"),
];
