import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/components/simple_info_row.dart';
import 'package:pm_flutter/constants/localization.dart';
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
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(Strings.issueDetails),
        ),
      ),
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
              _issue.subject,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(_issue.description ?? "", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 20),
            SimpleInfoRow(
              title: AppLocalizations.of(context).translate(Strings.issueStartDate),
              info: DateFormat.yMEd(
                AppLocalizations.of(context).locale.languageCode,
              ).format(_issue.startDate),
            ),
            SizedBox(height: 20),
            SimpleInfoRow(
              title: AppLocalizations.of(context).translate(Strings.issueDueDate),
              info: DateFormat.yMEd(
                AppLocalizations.of(context).locale.languageCode,
              ).format(_issue.dueDate),
            ),
            SizedBox(height: 20),
            SimpleInfoRow(
              title: "Becsült idő",
              info: _issue.estimatedHours.toString(),
            ),
            SizedBox(height: 20),
            // TODO:  maybe: show logs for this issue
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(context).translate(Strings.logWorktime),
                ),
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
