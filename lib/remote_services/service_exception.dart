class RemoteServiceException implements Exception {
  int _statusCode;
  String _message;

  int get statusCode => _statusCode;
  String get message => _message;

  RemoteServiceException(this._statusCode, this._message);

  String toString() => '$statusCode: $message';
}
