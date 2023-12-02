import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_sheet_conta_state.dart';

class BottomSheetContaCubit extends Cubit<BottomSheetContaState> {
  BottomSheetContaCubit() : super(BottomSheetContaInitial());
}
