class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class HttpException extends Failure {
  HttpException(super.message);
}