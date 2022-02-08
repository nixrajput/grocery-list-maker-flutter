import 'package:grocery_list_maker/models/grocery_item.dart';

class PdfData {
  final String? name;
  final String? address;
  final String? title;
  final List<GroceryItem?>? items;

  PdfData({
    this.name = '',
    this.address = '',
    this.title = '',
    required this.items,
  });
}
