part of 'add_transaction_cubit.dart';

enum AddTransactionStatus { initial, submitting, success, failure }

class AddTransactionState extends Equatable {
  final TransactionType type;
  final Category category;
  final DateTime date;
  final AddTransactionStatus status;
  final String? errorMessage;

  const AddTransactionState({
    this.type = TransactionType.expense,
    this.category = Category.food,
    required this.date,
    this.status = AddTransactionStatus.initial,
    this.errorMessage,
  });

  AddTransactionState copyWith({
    TransactionType? type,
    Category? category,
    DateTime? date,
    AddTransactionStatus? status,
    String? errorMessage,
  }) {
    return AddTransactionState(
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [type, category, date, status, errorMessage];
}
