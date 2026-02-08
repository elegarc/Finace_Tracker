import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracking/models/transaction.dart';
import 'package:expense_tracking/screens/transaction_list/bloc/transaction_bloc.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final TransactionBloc _transactionBloc;

  AddTransactionCubit(this._transactionBloc)
    : super(AddTransactionState(date: DateTime.now()));

  void typeChanged(TransactionType type) {
    emit(state.copyWith(type: type));
  }

  void categoryChanged(Category category) {
    emit(state.copyWith(category: category));
  }

  void dateChanged(DateTime date) {
    emit(state.copyWith(date: date));
  }

  void submitForm({
    required String title,
    required double amount,
    required String description,
  }) {
    try {
      emit(state.copyWith(status: AddTransactionStatus.submitting));

      final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: state.date,
        type: state.type,
        category: state.category,
        description: description,
      );

      _transactionBloc.add(TransactionAdded(newTransaction));
      emit(state.copyWith(status: AddTransactionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AddTransactionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
