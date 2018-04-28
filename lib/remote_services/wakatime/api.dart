import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import './wakatime_model.dart';
import '../service_exception.dart';

class WakatimeAPI {
  static const HOST = "wakatime.com";
  static const REST_V1_PATH = "api/v1";
  Map<String, String> _baseHeaders;
  http.Client _httpClient;

  WakatimeAPI(String apiKey, [http.Client httpClient]) {
    final encodedUserPass = base64.encode(utf8.encode(apiKey));
    final authenticationHeader = 'Basic $encodedUserPass';
    _baseHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authenticationHeader
    };
    if (httpClient != null) {
      _httpClient = httpClient;
    } else {
      _httpClient = new http.Client();
    }
  }

  Future<int> dayWorkSeconds(DateTime date) async {
    final response = await retrieveDay(date);
    if (response.data != null) {
      final totalWork = response.data.fold(0, (v, d) {
        if (d.projects != null) {
          final allProjectSeconds = d.projects.fold(0, (pv, p) {
            return p.totalSeconds + pv;
          });
          return allProjectSeconds + v;
        }
        return v;
      });
      return totalWork;
    }
    return 0;
  }

  Future<SummaryResponse> retrieveDay(DateTime date) async {
    final formattedDate = date.toIso8601String().substring(0, 10);
    final uri = new Uri(
        scheme: 'https',
        host: HOST,
        path: '$REST_V1_PATH/users/current/summaries',
        queryParameters: {'start': formattedDate, 'end': formattedDate});
    final res = await _httpClient.get(uri, headers: _baseHeaders);
    final statusCode = res.statusCode;
    final bodyStr = res.body;
    if (statusCode >= 200 && statusCode < 300) {
      final decodedJson = json.decode(bodyStr);
      return new SummaryResponse.fromJson(decodedJson);
    }
    throw new RemoteServiceException(statusCode, bodyStr);
  }
}
