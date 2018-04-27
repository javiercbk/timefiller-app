import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import './harvest_model.dart';
import '../service_exception.dart';

class HarvestAPI {
  static const String HOST = "api.harvestapp.com";
  static const String REST_V2_PATH = "api/v2";
  Map<String, String> _baseHeaders;
  http.Client _httpClient;

  HarvestAPI(String accountId, String token, [http.Client httpClient]) {
    _baseHeaders = {
      'Accept': 'application/json',
      'Harvest-Account-ID': accountId,
      'Authorization': 'Bearer $token',
      'User-Agent': 'Timefiller app'
    };
    if (httpClient != null) {
      _httpClient = httpClient;
    } else {
      _httpClient = new http.Client();
    }
  }

  Future<SearchTimeEntryResponse> retrieveTimeEntry(DateTime date) async {
    final formattedDate = date.toIso8601String().substring(0, 10);
    final uri = new Uri(
        scheme: 'https',
        host: HOST,
        path: '$REST_V2_PATH/time_entries',
        queryParameters: {'from': formattedDate, 'to': formattedDate});
    final res = await _httpClient.get(uri, headers: _baseHeaders);
    final statusCode = res.statusCode;
    final body = res.body;
    if (res.statusCode >= 200 && statusCode < 300) {
      final decodedJson = json.decode(res.body);
      return new SearchTimeEntryResponse.fromJson(decodedJson);
    }
    throw new RemoteServiceException(statusCode, body);
  }

  Future<CreateTimeEntryResponse> createTimeEntry(
      CreateTimeEntryRequest newTimeEntry) async {
    final jsonHeaders = new Map<String, String>.from(_baseHeaders);
    jsonHeaders['Content-Type'] = 'application/json';
    final uri = new Uri(
        scheme: 'https', host: HOST, path: '$REST_V2_PATH/time_entries');
    final bodyStr = json.encode(newTimeEntry.toJson());
    final res =
        await _httpClient.post(uri, headers: _baseHeaders, body: bodyStr);
    final statusCode = res.statusCode;
    final body = res.body;
    if (res.statusCode >= 200 && statusCode < 300) {
      final decodedJson = json.decode(res.body);
      return new CreateTimeEntryResponse.fromJson(decodedJson);
    }
    throw new RemoteServiceException(statusCode, body);
  }
}
