class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class HttpException extends Failure {
  Object? error;
  HttpException(super.message, {this.error});
}

class SaldoInsuficiente extends Failure {
  SaldoInsuficiente(super.message);
}
