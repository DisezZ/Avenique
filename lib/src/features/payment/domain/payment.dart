import 'package:objectbox/objectbox.dart';

import '../../account/domain/account.dart';
import '../../category/domain/category.dart';

@Entity()
class Payment {
  @Id()
  int id = 0;

  @Unique()
  String name;

  String type;

  String amount;

  @Property(type: PropertyType.date)
  DateTime date;

  final account = ToOne<Account>();
  final category = ToOne<Category>();

  Payment({
    required this.type,
    required this.name,
    required this.amount,
    required this.date,
  });
}
