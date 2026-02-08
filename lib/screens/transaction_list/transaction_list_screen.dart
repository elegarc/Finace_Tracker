import 'package:expense_tracking/theme/theme_cubit.dart';
import 'package:expense_tracking/screens/transaction_list/bloc/transaction_bloc.dart';
import 'package:expense_tracking/models/transaction.dart';
import 'package:expense_tracking/screens/add_transaction/add_transaction_screen.dart';
import 'package:expense_tracking/widgets/balance_card.dart';
import 'package:expense_tracking/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  @override
  void initState() {
    super.initState();
  }

  double _getBalance(List<Transaction> transactions) {
    double balance = 0.0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Expense Tracker'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: Icon(
                  context.watch<ThemeCubit>().state == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              BalanceCard(balance: _getBalance(state.transactions)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SegmentedButton<TransactionFilter>(
                  segments: const [
                    ButtonSegment(
                      value: TransactionFilter.all,
                      label: Text('All'),
                    ),
                    ButtonSegment(
                      value: TransactionFilter.income,
                      label: Text('Income'),
                    ),
                    ButtonSegment(
                      value: TransactionFilter.expense,
                      label: Text('Expense'),
                    ),
                  ],
                  selected: {state.filter},
                  onSelectionChanged: (Set<TransactionFilter> newSelection) {
                    context.read<TransactionBloc>().add(
                      TransactionFilterChanged(newSelection.first),
                    );
                  },
                ),
              ),
              Expanded(
                child: TransactionList(
                  transactions: state.filteredTransactions.toList(),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddTransactionScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
