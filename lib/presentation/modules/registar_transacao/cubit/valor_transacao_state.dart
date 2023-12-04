part of 'valor_transacao_cubit.dart';

sealed class ValorTransacaoState extends Equatable {
  const ValorTransacaoState(this.valor);

  final String valor;

  @override
  List<Object> get props => [valor];
}

final class ValorTransacaoInicial extends ValorTransacaoState {
  const ValorTransacaoInicial(super.valor);
}

final class ValorTransacaoChanged extends ValorTransacaoState {
  const ValorTransacaoChanged(super.valor);
}
