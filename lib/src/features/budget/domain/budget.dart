import 'package:objectbox/objectbox.dart';

import '../../account/domain/account.dart';
import '../../category/domain/category.dart';

@Entity()
class Budget {
  @Id()
  int id = 0;

  @Unique()
  String name;

  String amount;

  String period;

  final accounts = ToMany<Account>();

  final categories = ToMany<Category>();

  Budget({
    required this.name,
    required this.amount,
    required this.period,
  });
}
