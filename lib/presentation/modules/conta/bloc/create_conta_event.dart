part of 'create_conta_bloc.dart';

sealed class CreateContaEvent extends Equatable {
  const CreateContaEvent();

  @override
  List<Object> get props => [];
}

class GravarContaEvent extends CreateContaEvent {
  // final String descricao;
  final BuildContext context;
  final String nomeConta;

  const GravarContaEvent({
    // required this.descricao,
    required this.context,
    required this.nomeConta,
  });

  @override
  List<Object> get props => [nomeConta];
}
