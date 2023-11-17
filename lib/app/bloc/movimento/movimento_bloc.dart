import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movimento_event.dart';
part 'movimento_state.dart';

class MovimentoBloc extends Bloc<MovimentoEvent, MovimentoState> {

  MovimentoBloc() : super(MovimentoInitial()) {
    on<MovimentoEvent>((event, emit) {
      
    });

  }
}
