import 'package:avenique/src/common_widgets/drop_down_tile.dart';
import 'package:color_blindness/color_blindness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setting_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<SettingBloc>(context),
        child: SettingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingBloc = BlocProvider.of<SettingBloc>(context);
    // themeModeMap.forEach((value) {
    //   if (value == settingBloc.state.themeMode.name) {
    //     selected = value;
    //   }
    // });
    final settingList = [
      Card(
        child: DropDownTile(
          title: 'Theme',
          onChange: (String? value) {
            if (value != null) {
              settingBloc.add(SettingThemeModeChanged(value));
            }
          },
          selected: settingBloc.state.themeMode.name,
          values: ThemeMode.values.map((element) => element.name).toList(),
        ),
      ),
      Card(
        child: DropDownTile(
          title: 'Dynamic Color',
          onChange: (String? value) {
            if (value != null) {
              settingBloc.add(SettingDynamicColorStatusChanged(value));
            }
          },
          selected: settingBloc.state.dynamicColorStatus.name,
          values:
              DynamicColorStatus.values.map((element) => element.name).toList(),
        ),
      ),
      Card(
        child: DropDownTile(
          title: 'Color Blindness',
          onChange: (String? value) {
            if (value != null) {
              settingBloc.add(SettingColorBlindnessTypeChanged(value));
            }
          },
          selected: settingBloc.state.colorBlindnessType.name,
          values:
              ColorBlindnessType.values.map((element) => element.name).toList(),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: settingList.length,
          itemBuilder: (context, index) => settingList[index],
          separatorBuilder: (context, index) => SizedBox(height: 16),
        ),
      ),
    );
  }
}
