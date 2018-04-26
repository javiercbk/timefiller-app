// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.
import "dart:io";
import "package:test/test.dart";
import "package:path/path.dart" show dirname, join, normalize;
import 'package:http/http.dart' as http;
import "../lib/jira/api.dart";
import "./helpers/mock_http_client.dart";
import "./helpers/test_path.dart";

String _scriptPath() {
  return testFilePath(Platform.script.toString());
}

void main() {
  group("jira", () {
    test("Jira api should correctly parse a response from retrievedWorkLogged",
        () async {
      const host = "testdomain.atlassian.net";
      final mockHttpClient = new MockHttpClient();
      final jiraAPI =
          new JiraRestAPI(host, "sample@email.com", "123NOT", mockHttpClient);
      final time = new DateTime(2018, 4, 2);
      final currentDirectory = dirname(_scriptPath());
      final filePath = normalize(join(currentDirectory, 'data/worklogs.json'));
      final jsonRawData = await new File(filePath).readAsString();
      final responseBuilder =
          (String body) => new http.Response(jsonRawData, 200);
      mockHttpClient.addMockedResponse(new ResponseMock(RequestMethod.POST,
          "https://$host/rest/api/2/search", responseBuilder));
      final response = await jiraAPI.retrievedWorkLogged(time);
      expect(response, isNot(isNull));
      expect(response.total, equals(1));
      expect(response.issues, isNot(isNull));
      expect(response.issues.length, equals(1));
      final issue = response.issues[0];
      expect(issue.id, equals("1"));
      expect(issue.fields, isNot(isNull));
      expect(issue.fields.worklog, isNot(isNull));
      expect(issue.fields.worklog.total, equals(7));
      expect(issue.fields.worklog.worklogs, isNot(isNull));
      expect(issue.fields.worklog.worklogs.length, equals(7));
      final worklog = issue.fields.worklog.worklogs[0];
      expect(worklog.id, equals("1"));
      expect(worklog.issueId, equals("1"));
      expect(worklog.started, equals("2018-04-02T23:00:00.000-0400"));
      expect(worklog.timeSpent, equals("1d"));
      expect(worklog.timeSpentSeconds, equals(28800));
    });

    test("Jira api should correctly parse a response from retrieveIssueByKey",
        () async {
      const host = "testdomain.atlassian.net";
      final mockHttpClient = new MockHttpClient();
      final jiraAPI =
          new JiraRestAPI(host, "sample@email.com", "123NOT", mockHttpClient);
      final currentDirectory = dirname(_scriptPath());
      final filePath = normalize(join(currentDirectory, 'data/issue.json'));
      final jsonRawData = await new File(filePath).readAsString();
      final responseBuilder =
          (String body) => new http.Response(jsonRawData, 200);
      mockHttpClient.addMockedResponse(new ResponseMock(RequestMethod.POST,
          "https://$host/rest/api/2/search", responseBuilder));
      final response = await jiraAPI.retrieveIssueByKey("PRJ-1");
      expect(response, isNot(isNull));
      expect(response.total, equals(1));
      expect(response.issues, isNot(isNull));
      expect(response.issues.length, equals(1));
      final issue = response.issues[0];
      expect(issue.id, equals("1"));
      expect(issue.fields, isNot(isNull));
      expect(issue.fields.status, isNot(isNull));
      final status = issue.fields.status;
      expect(status.self,
          equals("https://testdomain.atlassian.net/rest/api/2/status/1"));
      expect(status.description, equals("Issue description"));
      expect(status.name, equals("CLOSED"));
      expect(status.id, equals("1"));
      expect(status.statusCategory, isNot(isNull));
      expect(status.statusCategory.id, equals(3));
      expect(status.statusCategory.key, equals("done"));
      expect(status.statusCategory.colorName, equals("green"));
      expect(status.statusCategory.name, equals("Done"));
    });

    test("Jira api should correctly parse a response from assignableIssues",
        () async {
      const host = "testdomain.atlassian.net";
      final mockHttpClient = new MockHttpClient();
      final jiraAPI =
          new JiraRestAPI(host, "sample@email.com", "123NOT", mockHttpClient);
      final currentDirectory = dirname(_scriptPath());
      final filePath = normalize(join(currentDirectory, 'data/issue.json'));
      final jsonRawData = await new File(filePath).readAsString();
      final responseBuilder =
          (String body) => new http.Response(jsonRawData, 200);
      mockHttpClient.addMockedResponse(new ResponseMock(RequestMethod.POST,
          "https://$host/rest/api/2/search", responseBuilder));
      final response = await jiraAPI
          .assignableIssues(project: "PRJ", statuses: const ['CLOSED']);
      expect(response, isNot(isNull));
      expect(response.total, equals(1));
      expect(response.issues, isNot(isNull));
      expect(response.issues.length, equals(1));
      final issue = response.issues[0];
      expect(issue.id, equals("1"));
      expect(issue.fields, isNot(isNull));
      expect(issue.fields.status, isNot(isNull));
      final status = issue.fields.status;
      expect(status.self,
          equals("https://testdomain.atlassian.net/rest/api/2/status/1"));
      expect(status.description, equals("Issue description"));
      expect(status.name, equals("CLOSED"));
      expect(status.id, equals("1"));
      expect(status.statusCategory, isNot(isNull));
      expect(status.statusCategory.id, equals(3));
      expect(status.statusCategory.key, equals("done"));
      expect(status.statusCategory.colorName, equals("green"));
      expect(status.statusCategory.name, equals("Done"));
    });

    test("Jira api should correctly parse a response from addWorklog",
        () async {
      const host = "testdomain.atlassian.net";
      final mockHttpClient = new MockHttpClient();
      final jiraAPI =
          new JiraRestAPI(host, "sample@email.com", "123NOT", mockHttpClient);
      final currentDirectory = dirname(_scriptPath());
      final filePath =
          normalize(join(currentDirectory, 'data/add_worklog.json'));
      final jsonRawData = await new File(filePath).readAsString();
      final responseBuilder =
          (String body) => new http.Response(jsonRawData, 200);
      mockHttpClient.addMockedResponse(new ResponseMock(
          RequestMethod.POST,
          "https://$host/rest/api/2/issue/PRJ-1/worklog?adjustEstimate=auto",
          responseBuilder));
      final time = new DateTime(2018, 4, 26);
      final response = await jiraAPI.addWorklog("PRJ-1", time, 28560);
      expect(response, isNot(isNull));
      expect(response.created, equals("2018-04-26T00:50:27.664-0400"));
      expect(response.updated, equals("2018-04-26T00:50:27.664-0400"));
      expect(response.started, equals("2018-04-25T02:00:00.000-0400"));
      expect(response.timeSpent, equals("7h 56m"));
      expect(response.timeSpentSeconds, equals(28560));
      expect(response.id, equals("8"));
      expect(response.issueId, equals("1"));
    });
  });
}
