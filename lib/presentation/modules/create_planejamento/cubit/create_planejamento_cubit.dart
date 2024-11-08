import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/entities/item_planejamento.dart';
import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_planejamento_state.dart';

class CreatePlanejamentoCubit extends Cubit<CreatePlanejamentoState> {
  CreatePlanejamentoCubit()
      : super(
          CreatePlanejamentoInitial(Planejamento.make()),
        );

  void updatePlafound(double doubleValue) {
    final planejamentoModel =
        state.planejamento.copyWith(plafound: doubleValue);

    emit(state.copyWith(
      planejamento: planejamentoModel,
    ));
  }

  void updateItens(List<ItemPlanejamento> itens) {
    // sort itens
    itens.sort((a, b) => a.categoria.name.compareTo(b.categoria.name));

    final planejamentoModel = state.planejamento.copyWith(itens: itens);

    emit(state.copyWith(
      planejamento: planejamentoModel,
    ));
  }

  void changeItemPlanejamentoPlafound(ItemPlanejamento itemPlanejamento) {
    final itens = state.planejamento.itens
        .map((e) => e.id == itemPlanejamento.id
            ? itemPlanejamento.copyWith(plafound: itemPlanejamento.plafound)
            : e)
        .toList();
    updateItens(itens);
  }

  void changeItemPlanejamentoCategorias(Categoria categoria) {
    final itens = state.planejamento.itens
        .map((e) => e.categoria.id == categoria.id
            ? e.copyWith(categoria: categoria)
            : e)
        .toList();
    updateItens(itens);
  }

  void addOrRemoveCategorias(Categoria categoria) {
    if (state.planejamento.itens.any((e) => e.categoria.id == categoria.id)) {
      final itens = state.planejamento.itens
          .where((e) => e.categoria.id != categoria.id)
          .toList();
      updateItens(itens);
    } else {
      final itens = [
        ...state.planejamento.itens,
        ItemPlanejamento.make(categoria)
      ];
      updateItens(itens);
    }
  }
}
