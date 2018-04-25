// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.
import "package:test/test.dart";
import "../lib/jira/api.dart";
import "./helpers/mock_http_client.dart";

void main() {
  group("jira", () {
    test("Jira api should correctly parse a response", () async {
      final jiraAPI = new JiraRestAPI("testdomain.atlassian.net",
          "sample@email.com", "123NOT", new MockHttpClient());
      final response = await jiraAPI.assignableIssues(
          project: "project", statuses: ['DEV-IN-PROGRESS', 'DEV-DONE']);
      expect(response, isNot(isNull));
    });
  });
}
