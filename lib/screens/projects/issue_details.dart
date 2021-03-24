import 'package:flutter/material.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/project.dart';
import 'package:pm_flutter/screens/projects/log_worktime.dart';

class IssueDetailsScreen extends StatelessWidget {
  final Issue _issue;
  final Project _project;

  IssueDetailsScreen(this._issue, this._project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Issue details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _project.name,
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
            ),
            //Text(_issue.projectId.toString()),
            SizedBox(height: 10),
            Text(
              _issue.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(_issue.description, style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 20),
            // TODO:  maybe: show logs for this issue
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Log Worktime"),
                onPressed: () => _openLogPage(context, _issue),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openLogPage(BuildContext context, Issue issue) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LogWorkTimeScreen(issue: issue)));
  }
}
