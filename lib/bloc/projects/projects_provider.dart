import 'dart:convert';

import 'package:pm_flutter/mock/issues.dart';
import 'package:pm_flutter/mock/projects.dart';
import 'package:pm_flutter/models/issue.dart';
import 'package:pm_flutter/models/project.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class ProjectsProvider {
  //var dio = Network.dio;
  Future<List<Project>> getProjectsList() async {
    // return Future.delayed(Duration(seconds: 1), () => mockProjects);

    var res = await Network.dio.get(Urls.PROJECT);
    print(res.data.toString());
    //var tmp = jsonDecode(res.data);
    List<Project> list = res.data.map<Project>(
      (item) {
        Map<String, dynamic> asd = item;
        print(asd);
        var x = Project.fromJson(asd);
        // return Project(
        //   id: asd["id"],
        //   name: asd["name"],
        //   description: asd["description"],
        // );
        return x;
      },
    ).toList();
    return list;
  }

  Future<List<Issue>> getIssuesForProject(int projectId) async {
    return Future.delayed(Duration(seconds: 1), () => mockIssues[projectId]);
    // var res = await Network.dio
    //     .get(Urls.ISSUE, queryParameters: {"projectId": projectId});
    // print(res.data.toString());
    // List<Issue> list = res.data.map<Issue>(
    //   (item) {
    //     Map<String, dynamic> asd = item;
    //     print(asd);
    //     var x = Issue.fromJson(asd);
    //     return x;
    //   },
    // ).toList();
    // return list;
  }
}
