import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'instituicao_financeira_state.dart';

class InstituicaoFinanceiraCubit extends Cubit<InstituicaoFinanceiraState> {
  InstituicaoFinanceiraCubit() : super(InstituicaoFinanceiraInitial());
}
