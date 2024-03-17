class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions(this._message, this._prefix);

  String toString() {
    return '${_prefix }${_message}';
  }
}

class InternetException extends AppExceptions {
  InternetException(message) : super(message, 'No internet');
}

class RequestTimedOutException extends AppExceptions {
  RequestTimedOutException(message) : super(message, 'Request timed out');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException(message) : super(message, 'Url does not exit');
}

class FetchDataException extends AppExceptions {
  FetchDataException(message) : super(message, 'Error while communicating with the server');
}