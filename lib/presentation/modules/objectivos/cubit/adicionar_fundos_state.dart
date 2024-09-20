part of 'adicionar_fundos_cubit.dart';

sealed class AdicionarFundosState extends Equatable {
  const AdicionarFundosState();

  @override
  List<Object> get props => [];
}

final class AdicionarFundosInitial extends AdicionarFundosState {}

final class AdicionarFundosLoading extends AdicionarFundosState {}

final class AdicionarFundosSuccess extends AdicionarFundosState {}

final class AdicionarFundosError extends AdicionarFundosState {
  final String message;

  const AdicionarFundosError(this.message);

  @override
  List<Object> get props => [message];
}
