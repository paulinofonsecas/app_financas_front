part of 'bottom_sheet_conta_cubit.dart';

sealed class BottomSheetContaState extends Equatable {
  const BottomSheetContaState();

  @override
  List<Object> get props => [];
}

final class BottomSheetContaInitial extends BottomSheetContaState {}

final class ListarContasLoading extends BottomSheetContaState {}

final class ListarContasError extends BottomSheetContaState {
  final String? errorMessage;

  const ListarContasError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class ListarContasSuccess extends BottomSheetContaState {
  final List<Conta> contas;

  const ListarContasSuccess(this.contas);

  @override
  List<Object> get props => [contas];
}
