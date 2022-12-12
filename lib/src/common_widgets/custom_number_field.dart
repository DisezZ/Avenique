import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class CustomNumberField extends StatefulWidget {
  const CustomNumberField(
      {super.key, required this.initialAmount, required this.callback});

  final String initialAmount;
  final void Function(String) callback;

  @override
  State<CustomNumberField> createState() => _CustomNumberFieldState();
}

class _CustomNumberFieldState extends State<CustomNumberField> {
  final _controller = TextEditingController();
  late String previousString;
  var offSet = 1;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialAmount;

    _controller.addListener(() {
      String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text == '' ? '0' : text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final double size = 300;

    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(size / 2)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: size,
        height: size,
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        // ),
        child: Center(
          child: TextFormField(
            // initialValue: widget.initialAmount,
            //autofocus: true,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            showCursor: true,
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            ),
            onChanged: widget.callback,
            textAlign: TextAlign.center,
            inputFormatters: [
              ThousandsFormatter(
                  formatter: NumberFormat.decimalPattern(), allowFraction: true)
            ],
          ),
        ),
      ),
    );
  }
}
