import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'mais_funcionalidades_state.dart';

class MaisFuncionalidadesCubit extends Cubit<MaisFuncionalidadesState> {
  MaisFuncionalidadesCubit() : super(const MaisFuncionalidadesInitial());

  /// A description for yourCustomFunction 
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
