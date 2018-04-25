import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class NotImplementedException implements Exception {
  NotImplementedException();

  String toString() => 'Not implemented';
}

class MockHttpClient implements http.Client {
  Future<http.Response> head(url, {Map<String, String> headers}) {
    throw new NotImplementedException();
  }

  Future<http.Response> get(url, {Map<String, String> headers}) {
    throw new NotImplementedException();
  }

  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw new NotImplementedException();
  }

  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw new NotImplementedException();
  }

  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw new NotImplementedException();
  }

  Future<http.Response> delete(url, {Map<String, String> headers}) {
    throw new NotImplementedException();
  }

  Future<String> read(url, {Map<String, String> headers}) {
    throw new NotImplementedException();
  }

  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    throw new NotImplementedException();
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw new NotImplementedException();
  }

  @override
  void close() {}
}
