part of 'setting_bloc.dart';

enum DynamicColorStatus { on, off }

class SettingState extends Equatable {
  const SettingState({
    this.themeMode = ThemeMode.system,
    this.colorBlindnessType = ColorBlindnessType.none,
    this.dynamicColorStatus = DynamicColorStatus.off,
  });

  final ThemeMode themeMode;
  final ColorBlindnessType colorBlindnessType;
  final DynamicColorStatus dynamicColorStatus;

  SettingState copyWith({
    ThemeMode? themeMode,
    ColorBlindnessType? colorBlindnessType,
    DynamicColorStatus? dynamicColorStatus,
  }) {
    return SettingState(
      themeMode: themeMode ?? this.themeMode,
      colorBlindnessType: colorBlindnessType ?? this.colorBlindnessType,
      dynamicColorStatus: dynamicColorStatus ?? this.dynamicColorStatus,
    );
  }

  @override
  List<Object?> get props =>
      [themeMode, colorBlindnessType, dynamicColorStatus];
}
