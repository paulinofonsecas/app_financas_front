import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_conta_event.dart';
part 'create_conta_state.dart';

class CreateContaBloc extends Bloc<CreateContaEvent, CreateContaState> {
  CreateContaBloc() : super(CreateContaInitial()) {
    on<CreateContaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
