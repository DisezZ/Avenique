import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  @Id()
  int id = 0;

  @Unique()
  String name;
  
  String nature;

  Category({
    required this.name,
    required this.nature,
  });
}
