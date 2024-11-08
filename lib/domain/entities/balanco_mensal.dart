import 'package:equatable/equatable.dart';

class BalancoMensal extends Equatable {
  final double saldo;
  final double saldoPrevisto;

  const BalancoMensal(this.saldo, this.saldoPrevisto);

  factory BalancoMensal.fake() {
    return const BalancoMensal(0, 0);
  }

  @override
  List<Object?> get props => [saldo, saldoPrevisto];
}
