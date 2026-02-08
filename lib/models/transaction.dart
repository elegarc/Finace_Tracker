import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  food,
  @HiveField(1)
  travel,
  @HiveField(2)
  shopping,
  @HiveField(3)
  bills,
  @HiveField(4)
  entertainment,
  @HiveField(5)
  others,
}

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 0)
class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.description,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final Category category;
  @HiveField(5)
  final TransactionType type;
  @HiveField(6)
  final String description;

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, amount: $amount, date: $date, category: $category, type: $type, description: $description)';
  }

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    date,
    category,
    type,
    description,
  ];
}
