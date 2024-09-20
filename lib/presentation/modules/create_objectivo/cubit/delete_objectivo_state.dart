part of 'delete_objectivo_cubit.dart';

sealed class DeleteObjectivoState extends Equatable {
  const DeleteObjectivoState();

  @override
  List<Object> get props => [];
}

final class DeleteObjectivoInitial extends DeleteObjectivoState {}
final class DeleteObjectivoLoading extends DeleteObjectivoState {}
final class DeleteObjectivoError extends DeleteObjectivoState {
  final String message;

  const DeleteObjectivoError(this.message);

  @override
  List<Object> get props => [message];
}

final class DeleteObjectivoSuccess extends DeleteObjectivoState {}
