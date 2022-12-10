import 'package:bloc/bloc.dart';
import 'package:color_blindness/color_blindness.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        super(SettingState()) {
    on<SettingStarted>(_onSettingStarted);
    on<SettingThemeModeChanged>(_onSettingThemeModeChanged);
    on<SettingColorBlindnessTypeChanged>(_onSettingColorBlindnessTypeChanged);
    on<SettingDynamicColorStatusChanged>(_onSettingDynamicColorStatusChanged);
  }

  final SharedPreferences _sharedPreferences;
  final _keyThemeMode = 'themeMode';
  final _keyColorBlindnessType = 'colorBlindnessType';
  final _keyDynamicColorStatus = 'dynamicColorStatus';

  void _onSettingStarted(
    SettingStarted event,
    Emitter<SettingState> emit,
  ) {
    final themeMode = _sharedPreferences.getString(_keyThemeMode);
    final colorBlindnessType = _sharedPreferences.getString(_keyColorBlindnessType);
    final dynamicColorStatus = _sharedPreferences.getString(_keyDynamicColorStatus);

    for (var element in ThemeMode.values) {
      if (element.name == themeMode) {
        emit(state.copyWith(themeMode: element));
      }
    }
    for (var element in ColorBlindnessType.values) {
      if (element.name == colorBlindnessType) {
        emit(state.copyWith(colorBlindnessType: element));
      }
    }
    for (var element in DynamicColorStatus.values) {
      if (element.name == dynamicColorStatus) {
        emit(state.copyWith(dynamicColorStatus: element));
      }
    }
  }

  void _onSettingThemeModeChanged(
    SettingThemeModeChanged event,
    Emitter<SettingState> emit,
  ) async {
    for (var element in ThemeMode.values) {
      if (element.name == event.themeMode) {
        await _sharedPreferences.setString(_keyThemeMode, event.themeMode);
        emit(state.copyWith(themeMode: element));
      }
    }
  }

  void _onSettingColorBlindnessTypeChanged(
    SettingColorBlindnessTypeChanged event,
    Emitter<SettingState> emit,
  ) async {
    for (var element in ColorBlindnessType.values) {
      if (element.name == event.colorBlindnessType) {
        await _sharedPreferences.setString(_keyColorBlindnessType, event.colorBlindnessType);
        emit(state.copyWith(colorBlindnessType: element));
      }
    }
  }

  void _onSettingDynamicColorStatusChanged(
    SettingDynamicColorStatusChanged event,
    Emitter<SettingState> emit,
  ) async {
    print(event.dynamicColorStatus);
    for (var element in DynamicColorStatus.values) {
      if (element.name == event.dynamicColorStatus) {
        await _sharedPreferences.setString(_keyDynamicColorStatus, event.dynamicColorStatus);
        emit(state.copyWith(dynamicColorStatus: element));
      }
    }
  }
}
