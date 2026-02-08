import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary.withValues(alpha: 0.8),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
