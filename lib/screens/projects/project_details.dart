import 'package:flutter/material.dart';
import 'package:pm_flutter/bloc/projects/projects_bloc.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/project.dart';
import 'package:pm_flutter/screens/projects/issue_details.dart';
import 'package:provider/provider.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  ProjectDetailsScreen(this.project);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  ProjectsBloc _projectsBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_projectsBloc == null) {
      _projectsBloc = Provider.of<ProjectsBloc>(context);
      _projectsBloc.getIssuesForProject(widget.project.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.project.name,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Text(widget.project.description),
              ],
            ),
          ),
          //SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<Issue>>(
              stream: _projectsBloc.issues,
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
                      onTap: () => _openIssueDetails(context, snapshot.data[i]),
                      title: Text(
                        snapshot.data[i].subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        snapshot.data[i].description ?? '', // TODO:
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

  void _openIssueDetails(BuildContext context, Issue issue) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => IssueDetailsScreen(issue, widget.project)));
  }
}
