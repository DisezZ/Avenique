import 'package:formz/formz.dart';

enum BalanceValidationError { empty }

class Balance extends FormzInput<String, BalanceValidationError> {
  const Balance.pure([super.value = '']) : super.pure();
  const Balance.dirty([super.value = '']) : super.dirty();

  @override
  BalanceValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : BalanceValidationError.empty;
  }
}