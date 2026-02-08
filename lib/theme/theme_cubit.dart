import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);
    _saveTheme(newMode);
  }

  void _loadTheme() {
    final index = _prefs.getInt('theme_mode');
    if (index != null) {
      emit(ThemeMode.values[index]);
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    await _prefs.setInt('theme_mode', mode.index);
  }
}
