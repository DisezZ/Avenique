import 'package:flutter/material.dart';

class DropDownTile extends StatelessWidget {
  const DropDownTile({
    super.key,
    required this.title,
    required this.selected,
    required this.values,
    required this.onChange,
  });

  final String title;
  final String selected;
  final List<String> values;
  final void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton(
        value: selected,
        items: values
            .asMap()
            .entries
            .map((e) =>
                DropdownMenuItem<String>(value: e.value, child: Text(e.value)))
            .toList(),
        onChanged: onChange,
      ),
    );
  }
}
