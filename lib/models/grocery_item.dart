import 'package:cv/cv.dart';
import 'package:grocery_list_maker/db/db.dart';
import 'package:grocery_list_maker/models/constant.dart';

class GroceryItem extends DbRecord {
  final title = CvField<String>(columnTitle);
  final description = CvField<String>(columnDescription);
  final quantity = CvField<String>(columnQuantity);
  final listId = CvField<int>(columnListId);
  final addedAt = CvField<String>(columnAddedAt);

  @override
  List<CvField<dynamic>> get fields =>
      [id, title, description, quantity, listId, addedAt];

  String getIndex(int index, int itemIndex) {
    switch (index) {
      case 0:
        return (itemIndex + 1).toString();
      case 1:
        return title.v.toString() + "\n${description.v.toString()}";
      case 2:
        return quantity.v.toString();
    }
    return '';
  }
}
