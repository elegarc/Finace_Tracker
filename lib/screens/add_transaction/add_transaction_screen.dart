import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracking/models/transaction.dart';
import 'package:expense_tracking/screens/add_transaction/cubit/add_transaction_cubit.dart';
import 'package:expense_tracking/injection_dependencies.dart' as di;

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AddTransactionCubit>(),
      child: const AddTransactionForm(),
    );
  }
}

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _presentDatePicker(BuildContext context, DateTime currentDate) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null && context.mounted) {
      context.read<AddTransactionCubit>().dateChanged(pickedDate);
    }
  }

  void _submitData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);
      final enteredDescription = _descriptionController.text;

      context.read<AddTransactionCubit>().submitForm(
        title: enteredTitle,
        amount: enteredAmount,
        description: enteredDescription,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTransactionCubit, AddTransactionState>(
      listener: (context, state) {
        if (state.status == AddTransactionStatus.success) {
          Navigator.of(context).pop();
        } else if (state.status == AddTransactionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Submission failed')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Transaction')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount.';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Amount must be greater than zero.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AddTransactionCubit, AddTransactionState>(
                    buildWhen: (previous, current) =>
                        previous.date != current.date,
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Date: ${DateFormat.yMd().format(state.date)}',
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                _presentDatePicker(context, state.date),
                            child: const Text('Choose Date'),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AddTransactionCubit, AddTransactionState>(
                    buildWhen: (previous, current) =>
                        previous.type != current.type,
                    builder: (context, state) {
                      return DropdownButtonFormField<TransactionType>(
                        initialValue: state.type,
                        decoration: const InputDecoration(labelText: 'Type'),
                        items: TransactionType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<AddTransactionCubit>().typeChanged(
                              value,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AddTransactionCubit, AddTransactionState>(
                    buildWhen: (previous, current) =>
                        previous.category != current.category,
                    builder: (context, state) {
                      return DropdownButtonFormField<Category>(
                        initialValue: state.category,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                        ),
                        items: Category.values.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<AddTransactionCubit>().categoryChanged(
                              value,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (Optional)',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AddTransactionCubit, AddTransactionState>(
                    builder: (context, state) {
                      if (state.status == AddTransactionStatus.submitting) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () => _submitData(context),
                        child: const Text('Add Transaction'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
