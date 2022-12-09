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

  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() {
  //     final String text = _controller.text;
  //     if (_controller.selection.baseOffset > 0 &&
  //         _controller.selection.baseOffset > _controller.text.length - 3) {
  //       setState(() {
  //         offSet = _controller.selection.baseOffset - 1;
  //       });
  //       _controller.value = _controller.value.copyWith(
  //         text: text,
  //         selection: TextSelection(baseOffset: offSet, extentOffset: offSet),
  //         composing: TextRange.empty,
  //       );
  //     } else if (_controller.selection.baseOffset > 0 &&
  //         _controller.selection.baseOffset <= _controller.text.length - 3) {
  //       setState(() {
  //         offSet = text.length - 3;
  //       });
  //       _controller.value = _controller.value.copyWith(
  //         // text: text[0] == '.' ? '0$text' : text,
  //         text: text,
  //         selection: TextSelection(baseOffset: offSet, extentOffset: offSet),
  //         composing: TextRange.empty,
  //       );
  //     } else {
  //       _controller.value = _controller.value.copyWith(
  //         text: text,
  //         selection: TextSelection(baseOffset: offSet, extentOffset: offSet),
  //         composing: TextRange.empty,
  //       );
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
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
    _controller.text = widget.initialAmount;

    return Container(
      padding: EdgeInsets.all(16),
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber,
      ),
      child: Center(
        child: TextFormField(
          //initialValue: widget.initialAmount,
          controller: _controller,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          showCursor: true,
          keyboardType: TextInputType.numberWithOptions(
            //signed: false,
            decimal: true,
          ),
          onChanged: (value) {
            widget.callback(value);
          },
          textAlign: TextAlign.center,
          inputFormatters: [
            ThousandsFormatter(
                formatter: NumberFormat('0.##'), allowFraction: true)
          ],
        ),
      ),
    );
  }
}
