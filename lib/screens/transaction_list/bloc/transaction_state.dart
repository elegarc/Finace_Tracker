part of 'transaction_bloc.dart';

enum TransactionFilter { all, income, expense }

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final TransactionFilter filter;

  const TransactionState({
    this.transactions = const [],
    this.filter = TransactionFilter.all,
  });

  Iterable<Transaction> get filteredTransactions {
    switch (filter) {
      case TransactionFilter.all:
        return transactions;
      case TransactionFilter.income:
        return transactions.where((t) => t.type == TransactionType.income);
      case TransactionFilter.expense:
        return transactions.where((t) => t.type == TransactionType.expense);
    }
  }

  TransactionState copyWith({
    List<Transaction>? transactions,
    TransactionFilter? filter,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [transactions, filter];

  Map<String, dynamic> toMap() {
    return {
      'transactions': transactions.map((x) {
        return {
          'id': x.id,
          'title': x.title,
          'amount': x.amount,
          'date': x.date.toIso8601String(),
          'category': x.category.index,
          'type': x.type.index,
          'description': x.description,
        };
      }).toList(),
      'filter': filter.index,
    };
  }

  factory TransactionState.fromMap(Map<String, dynamic> map) {
    return TransactionState(
      transactions: List<Transaction>.from(
        (map['transactions'] as List<dynamic>).map<Transaction>(
          (x) => Transaction(
            id: x['id'],
            title: x['title'],
            amount: x['amount'],
            date: DateTime.parse(x['date']),
            category: Category.values[x['category']],
            type: TransactionType.values[x['type']],
            description: x['description'],
          ),
        ),
      ),
      filter: TransactionFilter.values[map['filter']],
    );
  }
}
