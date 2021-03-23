import 'package:pm_flutter/models/worktime.dart';

List<WorkTime> worktimes = [
  WorkTime(
      id: 1,
      date: DateTime.now(),
      duration: 8,
      issueId: 11,
      userId: "asd",
      issueName: "Issue 11"),
  WorkTime(
      id: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
      duration: 8,
      issueId: 11,
      userId: "asd",
      issueName: "Issue 11"),
  WorkTime(
      id: 1,
      date: DateTime.now().subtract(Duration(days: 2)),
      duration: 8,
      issueId: 11,
      userId: "asd",
      issueName: "Issue 11"),
];
