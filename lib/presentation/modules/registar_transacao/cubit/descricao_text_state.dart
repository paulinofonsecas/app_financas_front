part of 'descricao_text_cubit.dart';

sealed class DescricaoTextState extends Equatable {
  const DescricaoTextState(this.descricao);

  final String descricao;

  @override
  List<Object> get props => [descricao];
}

final class DescricaoTextInitial extends DescricaoTextState {
  const DescricaoTextInitial(super.descricao) : super();
}

final class DescricaoTextChanged extends DescricaoTextState {
  const DescricaoTextChanged(super.descricao) : super();
}
