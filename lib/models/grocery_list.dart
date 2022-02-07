import 'package:cv/cv.dart';
import 'package:grocery_list_maker/db/db.dart';
import 'package:grocery_list_maker/models/constant.dart';

class GroceryList extends DbRecord {
  final title = CvField<String>(columnTitle);
  final description = CvField<String>(columnDescription);
  final addedAt = CvField<String>(columnAddedAt);

  @override
  List<CvField<dynamic>> get fields => [id, title, description, addedAt];
}
