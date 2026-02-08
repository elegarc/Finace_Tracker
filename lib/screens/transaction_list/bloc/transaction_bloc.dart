import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:expense_tracking/models/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final Box<Transaction> _transactionBox;

  TransactionBloc(this._transactionBox)
    : super(TransactionState(transactions: _transactionBox.values.toList())) {
    on<TransactionAdded>(_onTransactionAdded);
    on<TransactionDeleted>(_onTransactionDeleted);
    on<TransactionFilterChanged>(_onTransactionFilterChanged);
  }

  void _onTransactionAdded(
    TransactionAdded event,
    Emitter<TransactionState> emit,
  ) {
    _transactionBox.put(event.transaction.id, event.transaction);
    emit(state.copyWith(transactions: _transactionBox.values.toList()));
  }

  void _onTransactionDeleted(
    TransactionDeleted event,
    Emitter<TransactionState> emit,
  ) {
    _transactionBox.delete(event.id);
    emit(state.copyWith(transactions: _transactionBox.values.toList()));
  }

  void _onTransactionFilterChanged(
    TransactionFilterChanged event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }
}
