part of 'archive_conta_cubit.dart';

sealed class ArchiveContaState extends Equatable {
  const ArchiveContaState();

  @override
  List<Object> get props => [];
}

final class ArchiveContaInitial extends ArchiveContaState {}

class ArchiveContaLoading extends ArchiveContaState {}

class ArchiveContaSuccess extends ArchiveContaState {}

class ArchiveContaError extends ArchiveContaState {
  final String message;

  const ArchiveContaError(this.message);

  @override
  List<Object> get props => [message];
}
