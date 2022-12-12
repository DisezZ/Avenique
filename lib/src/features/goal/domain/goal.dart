import 'package:objectbox/objectbox.dart';

@Entity()
class Goal {
  @Id()
  int id = 0;

  @Unique()
  String name;

  String targetAmount;

  String currentAmount;

  @Property(type: PropertyType.date)
  DateTime endDate;

  Goal({
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.endDate,
  });
}
