// Package imports:
import 'package:objectbox/objectbox.dart';

import '../../budget/domain/budget.dart';
import '../../goal/domain/goal.dart';
import '../../payment/domain/payment.dart';
import '../../record/domain/record.dart';

@Entity()
class Account {
  @Id()
  int id = 0;

  @Unique()
  @Index(type: IndexType.hash)
  String name;

  String balance;

  @Backlink('account')
  final records = ToMany<Record>();

  @Backlink('accounts')
  final budgets = ToMany<Budget>();

  final goals = ToMany<Goal>();

  @Backlink('account')
  final payments = ToMany<Payment>();

  Account({
    required this.name,
    required this.balance,
  });
}
