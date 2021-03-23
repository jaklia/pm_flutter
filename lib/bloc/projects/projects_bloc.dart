import 'package:pm_flutter/bloc/projects/projects_repository.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/project.dart';
import 'package:rxdart/subjects.dart';

class ProjectsBloc {
  final _repository = ProjectsRepository();
  final _projects = BehaviorSubject<List<Project>>.seeded([]);

  final _issues = BehaviorSubject<List<Issue>>();

  get projects {
    return _projects.stream;
  }

  get issues {
    return _issues.stream;
  }

  Future<void> getProjectsList() async {
    var res = await _repository.getProjectsList();
    _projects.sink.add(res);
  }

  Future<void> getIssuesForProject(int projectId) async {
    _issues.sink.add([]);
    var res = await _repository.getIssuesForProject(projectId);
    _issues.sink.add(res);
  }

  void dispose() {
    _projects.close();
    _issues.close();
  }
}
