part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingStarted extends SettingEvent {
  const SettingStarted();
}

class SettingThemeModeChanged extends SettingEvent {
  const SettingThemeModeChanged(this.themeMode);

  final String themeMode;

  @override
  List<Object> get props => [themeMode];
}

class SettingColorBlindnessTypeChanged extends SettingEvent {
  const SettingColorBlindnessTypeChanged(this.colorBlindnessType);

  final String colorBlindnessType;

  @override
  List<Object> get props => [colorBlindnessType];
}

class SettingDynamicColorStatusChanged extends SettingEvent {
  const SettingDynamicColorStatusChanged(this.dynamicColorStatus);

  final String dynamicColorStatus;

  @override
  List<Object> get props => [dynamicColorStatus];
}