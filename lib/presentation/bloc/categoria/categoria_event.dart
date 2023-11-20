// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'categoria_bloc.dart';

sealed class CategoriaEvent extends Equatable {
  const CategoriaEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriaByIdEvent extends CategoriaEvent {
  final int id;
  final int categoriaTipoId;

  const GetCategoriaByIdEvent({
    required this.id,
    required this.categoriaTipoId,
  });

  @override
  List<Object> get props => [id, categoriaTipoId];
}
