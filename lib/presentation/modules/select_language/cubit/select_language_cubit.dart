import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'select_language_state.dart';

class SelectLanguageCubit extends Cubit<SelectLanguageState> {
  SelectLanguageCubit() : super(const SelectLanguageInitial());

  /// A description for yourCustomFunction 
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
