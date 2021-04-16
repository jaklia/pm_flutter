//  "http://localhost:51459"  iis
//  https://localhost:44342   iis   https
//  "http://localhost:5001"

class Urls {
  static const DEV_URL = "https://localhost:44342";
  static const STAGE_URL = "https://pmbackendapi1.azurewebsites.net";

  static const BASEURL = STAGE_URL;

  static const LOGIN = "/api/auth/login";
  static const LOGOUT = "/api/logout";

  static const PROJECT = "/api/projects";
  static const ISSUE = "/api/issues";
  static const TIMEENTRY = "/api/timeentries";
  static const MEETING = "/api/meetings";
  static const ROOM = "/api/rooms";
  static const USERS = "/api/users";

  static const ADMIN = "/api/admin/worktime";
}
