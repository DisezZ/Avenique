import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Project imports:
import '../../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Admin admin;

  ObjectBox._create(this.store) {
    if (Admin.isAvailable()) {
      admin = Admin(store);
    }
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    
    final store =
        await openStore(directory: p.join(docsDir.path, "obx-avenique"));
    
    return ObjectBox._create(store);
  }
}
