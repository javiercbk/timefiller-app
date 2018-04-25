import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import './jira_model.dart';

class JiraRestAPI {
  final String _host;
  Map<String, String> _baseHeaders;
  Uri baseURI;
  http.Client _httpClient;

  JiraRestAPI(this._host, username, password, [http.Client httpClient]) {
    final encodedUserPass = base64.encode(utf8.encode('$username:$password'));
    final authenticationHeader = 'Basic $encodedUserPass';
    _baseHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    _baseHeaders['Authorization'] = authenticationHeader;
    if (httpClient != null) {
      _httpClient = httpClient;
    } else {
      _httpClient = new http.Client();
    }
  }

  Future<AddWorklogResponse> addWorklog(
      String issueId, DateTime date, int seconds) async {
    final uri = new Uri(
        scheme: 'https',
        host: _host,
        path: 'rest/api/2/issue/$issueId/worklog?adjustEstimate=auto');
    final addWorklogRequest =
        new AddWorklogRequest(started: date, timeSpentSeconds: seconds);
    final bodyStr = json.encode(addWorklogRequest.toJson());
    final res =
        await _httpClient.post(uri, headers: _baseHeaders, body: bodyStr);
    final statusCode = res.statusCode;
    final body = res.body;
    if (res.statusCode >= 200 && statusCode < 300) {
      final decodedJson = json.decode(res.body);
      return new AddWorklogResponse.fromJson(decodedJson);
    }
    throw new JiraRestException(statusCode, body);
  }

  Future<SearchIssueResponse> retrievedWorkLogged(DateTime date) {
    final formattedDate =
        "${date.year.toString()}/${date.month.toString().padLeft(2,'0')}/${date.day.toString().padLeft(2,'0')}";
    final issueRequest = new SearchIssueRequest(
        jql: 'worklogAuthor=currentUser() AND worklogDate = "$formattedDate"',
        startAt: 0,
        maxResults: 1000,
        fields: ["worklog", "worklogs", "status"]);
    return _searchIssues(issueRequest);
  }

  Future<SearchIssueResponse> retrieveIssueByKey(String key) {
    final issueRequest = new SearchIssueRequest(
        jql: 'key="$key"',
        startAt: 0,
        maxResults: 1000,
        fields: ["worklog", "worklogs", "status"]);
    return _searchIssues(issueRequest);
  }

  Future<SearchIssueResponse> assignableIssues(
      {String project, List<String> statuses}) {
    final jqlSb = new StringBuffer();
    jqlSb.write('assignee=currentUser()');
    if (project != null) {
      jqlSb.write(' AND project=$project');
    }
    if (statuses != null && statuses.length > 0) {
      jqlSb.write(' AND (');
      jqlSb.write(statuses.map((s) => 'status=$s').join(' OR '));
      jqlSb.write(')');
    }
    final issueRequest = new SearchIssueRequest(
        jql: jqlSb.toString(),
        startAt: 0,
        maxResults: 1000,
        fields: ["worklog", "worklogs", "status"]);
    return _searchIssues(issueRequest);
  }

  Future<SearchIssueResponse> _searchIssues(SearchIssueRequest searchIssue,
      [SearchIssueResponse previousResponse]) async {
    final uri =
        new Uri(scheme: 'https', host: _host, path: 'rest/api/2/search');
    final bodyStr = json.encode(searchIssue.toJson());
    final res =
        await _httpClient.post(uri, headers: _baseHeaders, body: bodyStr);
    final statusCode = res.statusCode;
    final body = res.body;
    if (res.statusCode >= 200 && statusCode < 300) {
      final decodedJson = json.decode(res.body);
      final issueResponse = new SearchIssueResponse.fromJson(decodedJson);
      final issuesLen = issueResponse.issues.length;
      if (previousResponse != null) {
        previousResponse.issues.addAll(issueResponse.issues);
        issueResponse.issues = previousResponse.issues;
      }
      if (issuesLen == searchIssue.maxResults) {
        searchIssue.startAt += issuesLen;
        return _searchIssues(searchIssue, issueResponse);
      } else {
        return issueResponse;
      }
    }
    throw new JiraRestException(statusCode, body);
  }
}
