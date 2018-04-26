import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class NotImplementedException implements Exception {
  NotImplementedException();

  String toString() => 'Not implemented';
}

enum RequestMethod { GET, POST, PUT, DELETE, PATCH, HEAD }

typedef http.Response ResponseGenerator(String body);

class ResponseMock {
  final RequestMethod method;
  final String url;
  final ResponseGenerator buildResponse;

  ResponseMock(this.method, this.url, this.buildResponse);

  bool matches(RequestMethod method, url) {
    return method == this.method && url.toString() == this.url.toString();
  }
}

class ResponseMockNotFoundException implements Exception {
  String _cause;

  ResponseMockNotFoundException(RequestMethod method, url) {
    _cause = 'ResponseMock not found for $method $url';
  }

  String get cause => _cause;

  String toString() => cause;
}

class MockHttpClient implements http.Client {
  final List<ResponseMock> _mockedResponses = new List<ResponseMock>();

  MockHttpClient addMockedResponse(ResponseMock mockedResponse) {
    _mockedResponses.add(mockedResponse);
    return this;
  }

  http.Response _mockedResponse(RequestMethod method, url, [String body]) {
    final mockedResponse = _mockedResponses.firstWhere(
        (mocked) => mocked.matches(method, url),
        orElse: () => null);
    if (mockedResponse != null) {
      return mockedResponse.buildResponse(body);
    }
    throw new ResponseMockNotFoundException(method, url);
  }

  Future<http.Response> head(url, {Map<String, String> headers}) async {
    return _mockedResponse(RequestMethod.HEAD, url);
  }

  Future<http.Response> get(url, {Map<String, String> headers}) async {
    return _mockedResponse(RequestMethod.GET, url);
  }

  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    return _mockedResponse(RequestMethod.POST, url, body);
  }

  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    return _mockedResponse(RequestMethod.PUT, url, body);
  }

  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    return _mockedResponse(RequestMethod.PATCH, url, body);
  }

  Future<http.Response> delete(url, {Map<String, String> headers}) async {
    return _mockedResponse(RequestMethod.DELETE, url);
  }

  Future<String> read(url, {Map<String, String> headers}) async {
    final response = _mockedResponse(RequestMethod.GET, url);
    return response.body;
  }

  Future<Uint8List> readBytes(url, {Map<String, String> headers}) async {
    final response = _mockedResponse(RequestMethod.GET, url);
    return UTF8.encode(response.body);
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw new NotImplementedException();
  }

  @override
  void close() {}
}
