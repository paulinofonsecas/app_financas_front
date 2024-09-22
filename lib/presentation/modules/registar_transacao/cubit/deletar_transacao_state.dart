part of 'deletar_transacao_cubit.dart';

sealed class DeleteTransacaoState extends Equatable {
  const DeleteTransacaoState();

  @override
  List<Object> get props => [];
}

final class DeleteTransacaoInitial extends DeleteTransacaoState {}

final class DeleteTransacaoLoading extends DeleteTransacaoState {}

final class DeleteTransacaoSuccess extends DeleteTransacaoState {}

final class DeleteTransacaoError extends DeleteTransacaoState {}
