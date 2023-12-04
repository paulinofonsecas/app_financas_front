part of 'registar_transacao_bloc.dart';

sealed class RegistarTransacaoState extends Equatable {
  const RegistarTransacaoState();

  @override
  List<Object> get props => [];
}

final class RegistarTransacaoInitial extends RegistarTransacaoState {}

final class RegistarTransacaoLoading extends RegistarTransacaoState {}

final class RegistarTransacaoSuccess extends RegistarTransacaoState {}

final class RegistarTransacaoError extends RegistarTransacaoState {
  final String? errorMessage;
  final ErrorType? errorType;

  const RegistarTransacaoError({this.errorMessage, this.errorType});

  @override
  List<Object> get props => [errorMessage ?? '', errorType ?? ''];
}
