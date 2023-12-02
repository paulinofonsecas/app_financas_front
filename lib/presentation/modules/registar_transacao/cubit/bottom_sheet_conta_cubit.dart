import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_sheet_conta_state.dart';

class BottomSheetContaCubit extends Cubit<BottomSheetContaState> {
  BottomSheetContaCubit() : super(BottomSheetContaInitial());

  void listContas() {
    print('listContas');
  }
}
