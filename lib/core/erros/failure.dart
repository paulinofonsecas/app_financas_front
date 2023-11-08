class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class ValorInvalido implements Failure {
  @override
  final String message;
  
  ValorInvalido(this.message);
}

class HttpException extends Failure {
  Object? error;
  HttpException(super.message, {this.error});
}

class NotFoundError extends Failure {
  Object? error;
  NotFoundError(super.message, {this.error});
}

class DbException extends Failure {
  Object? error;
  DbException(super.message, {this.error});
}

class SaldoInsuficiente extends Failure {
  SaldoInsuficiente(super.message);
}
