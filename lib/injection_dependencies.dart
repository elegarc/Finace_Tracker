import 'package:get_it/get_it.dart';
import 'theme/theme_cubit.dart';
import 'screens/transaction_list/bloc/transaction_bloc.dart';
import 'screens/add_transaction/cubit/add_transaction_cubit.dart';
import 'package:hive/hive.dart';
import 'package:expense_tracking/models/transaction.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init(Box<Transaction> transactionBox) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => transactionBox);
  sl.registerLazySingleton(() => ThemeCubit(sl()));
  sl.registerLazySingleton(() => TransactionBloc(sl()));
  sl.registerFactory(() => AddTransactionCubit(sl()));
}
