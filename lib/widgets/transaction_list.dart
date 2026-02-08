import 'package:expense_tracking/models/transaction.dart';
import 'package:expense_tracking/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              //Placeholder for an image if we had one
              child: Icon(
                Icons.hourglass_empty,
                size: 100,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        return TransactionItem(transaction: transactions[index]);
      },
    );
  }
}
