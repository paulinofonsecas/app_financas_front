part of 'movimento_bloc.dart';

sealed class MovimentoEvent extends Equatable {
  const MovimentoEvent();

  @override
  List<Object> get props => [];
}

class MovimentoGetPaginatedListEvent extends MovimentoEvent {
  final int page;
  final int pageSize;

  const MovimentoGetPaginatedListEvent(this.page, this.pageSize);

  @override
  List<Object> get props => [page, pageSize];
}

class MovimentoGetPaginatedListByContaEvent extends MovimentoEvent {
  final int page;
  final int pageSize;

  const MovimentoGetPaginatedListByContaEvent(this.page, this.pageSize);

  @override
  List<Object> get props => [page, pageSize];
}
