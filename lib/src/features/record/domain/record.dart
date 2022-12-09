import 'package:objectbox/objectbox.dart';

import '../../account/domain/account.dart';
import '../../category/domain/category.dart';

@Entity()
class Record {
  @Id()
  int id = 0;

  String type;

  String amount;

  String note;

  @Property(type: PropertyType.date)
  DateTime date;

  final account = ToOne<Account>();

  final category = ToOne<Category>();

  Record({
    required this.type,
    required this.amount,
    required this.note,
    required this.date,
  });
}
