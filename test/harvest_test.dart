import "dart:io";
import "dart:async";
import "package:test/test.dart";
import "package:path/path.dart" show dirname, join, normalize;
import 'package:http/http.dart' as http;
import "../lib/remote_services/harvest/api.dart";
import "../lib/remote_services/harvest/harvest_model.dart";
import "./helpers/mock_http_client.dart";
import "./helpers/test_path.dart";

final _scriptPath = testFilePath(Platform.script.toString());
final currentDirectory = dirname(_scriptPath);

Future<HarvestAPI> buildTestHarvestAPI(
    RequestMethod method, String testSourceDataPath,
    [String queryParams]) async {
  final mockHttpClient = new MockHttpClient();
  final harvestAPI = new HarvestAPI("123123", "123123.123123", mockHttpClient);
  final filePath = normalize(join(currentDirectory, testSourceDataPath));
  final jsonRawData = await new File(filePath).readAsString();
  final responseBuilder = (String body) => new http.Response(jsonRawData, 200);
  String url =
      "https://${HarvestAPI.HOST}/${HarvestAPI.REST_V2_PATH}/time_entries";
  if (queryParams != null) {
    url = '$url?$queryParams';
  }
  mockHttpClient
      .addMockedResponse(new ResponseMock(method, url, responseBuilder));
  return harvestAPI;
}

void main() {
  group("harvest", () {
    test("Harvest api should correctly parse a response from retrieveTimeEntry",
        () async {
      final date = new DateTime.now();
      final dateISO8601 = date.toIso8601String().substring(0, 10);
      final harvestAPI = await buildTestHarvestAPI(RequestMethod.GET,
          'data/time_entries.json', 'from=$dateISO8601&to=$dateISO8601');
      final response = await harvestAPI.retrieveTimeEntry(new DateTime.now());
      expect(response, isNot(isNull));
      expect(response.timeEntries, isNot(isNull));
      expect(response.timeEntries.length, equals(4));
      final timeEntry = response.timeEntries[0];
      expect(timeEntry.user, isNot(isNull));
      expect(timeEntry.user.id, equals(1782959));
      expect(timeEntry.user.name, equals("Kim Allen"));
      expect(timeEntry.client, isNot(isNull));
      expect(timeEntry.client.id, equals(5735774));
      expect(timeEntry.client.name, equals("ABC Corp"));
      expect(timeEntry.project, isNot(isNull));
      expect(timeEntry.project.id, equals(14307913));
      expect(timeEntry.project.name, equals("Marketing Website"));
      expect(timeEntry.task, isNot(isNull));
      expect(timeEntry.task.id, equals(8083365));
      expect(timeEntry.task.name, equals("Graphic Design"));
      expect(timeEntry.userAssignment.id, equals(125068553));
      expect(timeEntry.userAssignment.isProjectManager, equals(true));
      expect(timeEntry.userAssignment.isActive, equals(true));
      expect(
          timeEntry.userAssignment.createdAt, equals("2017-06-26T22:32:52Z"));
      expect(
          timeEntry.userAssignment.updatedAt, equals("2017-06-26T22:32:52Z"));
      expect(timeEntry.userAssignment.hourlyRate, equals(100.0));
      expect(timeEntry.taskAssignment, isNot(isNull));
      expect(timeEntry.taskAssignment.id, equals(155502709));
      expect(timeEntry.taskAssignment.billable, equals(true));
      expect(timeEntry.taskAssignment.isActive, equals(true));
      expect(
          timeEntry.taskAssignment.createdAt, equals("2017-06-26T21:36:23Z"));
      expect(
          timeEntry.taskAssignment.updatedAt, equals("2017-06-26T21:36:23Z"));
      expect(timeEntry.invoice, isNot(isNull));
      expect(timeEntry.invoice.id, equals(13150403));
      expect(timeEntry.invoice.number, equals("1001"));
      expect(timeEntry.taskAssignment.hourlyRate, equals(100.0));
      expect(timeEntry.hours, equals(2.0));
      expect(timeEntry.notes, equals("Adding CSS styling"));
      expect(timeEntry.createdAt, equals("2017-06-27T15:50:15Z"));
      expect(timeEntry.updatedAt, equals("2017-06-27T16:47:14Z"));
      expect(timeEntry.isLocked, equals(true));
      expect(timeEntry.lockedReason,
          equals("Item Approved and Locked for this Time Period"));
      expect(timeEntry.billable, equals(true));
      expect(timeEntry.budgeted, equals(true));
      expect(timeEntry.billableRate, equals(100.0));
      expect(timeEntry.costRate, equals(50.0));
      expect(timeEntry.isClosed, equals(true));
      expect(timeEntry.isBilled, equals(false));
      expect(timeEntry.timerStartedAt, isNull);
      expect(timeEntry.startedTime, equals("3:00pm"));
      expect(timeEntry.endedTime, equals("5:00pm"));
      expect(timeEntry.isRunning, equals(false));
      expect(response.perPage, equals(100));
      expect(response.totalPages, equals(1));
      expect(response.totalEntries, equals(4));
      expect(response.nextPage, isNull);
      expect(response.previousPage, isNull);
      expect(response.page, equals(1));
      expect(response.links, isNot(isNull));
      expect(
          response.links.first,
          equals(
              "https://api.harvestapp.com/v2/time_entries?page=1&per_page=100"));
      expect(
          response.links.last,
          equals(
              "https://api.harvestapp.com/v2/time_entries?page=1&per_page=100"));
    });

    test("Harvest api should correctly parse a response from createTimeEntry",
        () async {
      final harvestAPI = await buildTestHarvestAPI(
          RequestMethod.POST, 'data/create_time_entry.json');
      final response = await harvestAPI.createTimeEntry(
          new CreateTimeEntryRequest(
              hours: 8.0,
              projectId: 1,
              spentDate: new DateTime.now(),
              taskId: 1,
              userId: 1));
      expect(response, isNot(isNull));
      expect(response.user, isNot(isNull));
      expect(response.user.id, equals(1782959));
      expect(response.user.name, equals("Kim Allen"));
      expect(response.client, isNot(isNull));
      expect(response.client.id, equals(5735774));
      expect(response.client.name, equals("ABC Corp"));
      expect(response.project, isNot(isNull));
      expect(response.project.id, equals(14307913));
      expect(response.project.name, equals("Marketing Website"));
      expect(response.task, isNot(isNull));
      expect(response.task.id, equals(8083365));
      expect(response.task.name, equals("Graphic Design"));
      expect(response.userAssignment, isNot(isNull));
      expect(response.userAssignment.id, equals(125068553));
      expect(response.userAssignment.isProjectManager, equals(true));
      expect(response.userAssignment.isActive, equals(true));
      expect(response.userAssignment.createdAt, equals("2017-06-26T22:32:52Z"));
      expect(response.userAssignment.updatedAt, equals("2017-06-26T22:32:52Z"));
      expect(response.userAssignment.hourlyRate, equals(100.0));
      expect(response.taskAssignment, isNot(isNull));
      expect(response.taskAssignment.id, equals(155502709));
      expect(response.taskAssignment.billable, equals(true));
      expect(response.taskAssignment.isActive, equals(true));
      expect(response.taskAssignment.createdAt, equals("2017-06-26T21:36:23Z"));
      expect(response.taskAssignment.updatedAt, equals("2017-06-26T21:36:23Z"));
      expect(response.taskAssignment.hourlyRate, equals(100.0));
      expect(response.id, equals(636718192));
      expect(response.spentDate, equals("2017-03-21"));
      expect(response.hours, equals(1.0));
      expect(response.notes, isNull);
      expect(response.createdAt, equals("2017-06-27T16:01:23Z"));
      expect(response.updatedAt, equals("2017-06-27T16:01:23Z"));
      expect(response.isLocked, equals(false));
      expect(response.lockedReason, isNull);
      expect(response.isClosed, equals(false));
      expect(response.isBilled, equals(false));
      expect(response.timerStartedAt, isNull);
      expect(response.startedTime, isNull);
      expect(response.endedTime, isNull);
      expect(response.isRunning, equals(false));
      expect(response.invoice, isNull);
      expect(response.billable, equals(true));
      expect(response.budgeted, equals(true));
      expect(response.billableRate, equals(100.0));
      expect(response.costRate, equals(50.0));
    });
  });
}
