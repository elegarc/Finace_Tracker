part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionAdded extends TransactionEvent {
  final Transaction transaction;

  const TransactionAdded(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionDeleted extends TransactionEvent {
  final String id;

  const TransactionDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class TransactionFilterChanged extends TransactionEvent {
  final TransactionFilter filter;

  const TransactionFilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}
