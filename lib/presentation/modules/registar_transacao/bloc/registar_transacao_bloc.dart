import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registar_transacao_event.dart';
part 'registar_transacao_state.dart';

class RegistarTransacaoBloc extends Bloc<RegistarTransacaoEvent, RegistarTransacaoState> {
  RegistarTransacaoBloc() : super(RegistarTransacaoInitial()) {
    on<RegistarTransacaoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
