import 'package:pm_flutter/bloc/projects/projects_provider.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/project.dart';

class ProjectsRepository {
  final _provider = ProjectsProvider();

  List<Project> _projects;
  Map<int, List<Issue>> _issues = {};

  Future<List<Project>> getProjectsList() async {
    var res = await _provider.getProjectsList();
    _projects = res;
    return res;
  }

  Future<List<Issue>> getIssuesForProject(int projectId) async {
    var res = await _provider.getIssuesForProject(projectId);
    _issues[projectId] = res;
    return res;
  }
}
