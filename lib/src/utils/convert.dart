import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class Convert {
  static Decimal convertStringToDecimal(String string) =>
      Decimal.parse(string.replaceAll(RegExp(','), ''));

  static String convertDecimalToString(Decimal decimal) =>
      NumberFormat.decimalPattern().format(decimal.toDouble());
}
