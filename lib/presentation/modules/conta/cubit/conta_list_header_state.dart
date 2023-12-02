part of 'conta_list_header_cubit.dart';

sealed class ContaListHeaderState extends Equatable {
  const ContaListHeaderState();

  @override
  List<Object> get props => [];
}

final class ContaListHeaderInitial extends ContaListHeaderState {
  final BalancoMensal balanco;

  const ContaListHeaderInitial(this.balanco);

  @override
  List<Object> get props => [balanco];
}

final class ContaListHeaderLoading extends ContaListHeaderState {}

final class ContaListHeaderEmpty extends ContaListHeaderState {}

final class ContaListHeaderSuccess extends ContaListHeaderState {
  final BalancoMensal balanco;

  const ContaListHeaderSuccess(this.balanco);

  @override
  List<Object> get props => [balanco];
}

final class ContaListHeaderError extends ContaListHeaderState {}
