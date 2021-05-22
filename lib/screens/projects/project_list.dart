import 'package:flutter/material.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/projects/projects_bloc.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/project.dart';
import 'package:pm_flutter/screens/projects/project_details.dart';
import 'package:provider/provider.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  ProjectsBloc _projectsBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_projectsBloc == null) {
      _projectsBloc = Provider.of<ProjectsBloc>(context);
    }
    // Future.delayed(Duration(milliseconds: 500));
    _projectsBloc.getProjectsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate(Strings.projects)),
      ),
      body: StreamBuilder<List<Project>>(
        stream: _projectsBloc.projects,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("Something went wrong!\n${snapshot.error.toString()}"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    child: Container(
                      child: ListTile(
                        onTap: () => _openProjectDetails(context, snapshot.data[i]),
                        title: Text(
                          snapshot.data[i].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          snapshot.data[i].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )));

            //  return ListView.separated(
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   itemCount: snapshot.data.length,
            //   itemBuilder: (context, i) => ListTile(
            //     onTap: () => _openProjectDetails(context, snapshot.data[i]),
            //     title: Text(
            //       snapshot.data[i].name,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //     subtitle: Text(
            //       snapshot.data[i].description,
            //       maxLines: 2,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //   ),
            //   separatorBuilder: (context, i) => Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16),
            //       child: Divider()),
            // );

          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _openProjectDetails(BuildContext context, Project project) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProjectDetailsScreen(project)));
  }
}

/*

 // Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: <Widget>[
      //     Text("xxxxxx"),
          // Expanded(
          //   child: 
            StreamBuilder<List<Project>>( . . . . ),
          // ),
      //   ],
      // ),

*/
