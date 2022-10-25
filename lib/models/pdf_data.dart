import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pdf_data.g.dart';

@CopyWith()
@JsonSerializable()
class PdfData {
  PdfData({
    this.name,
    this.address,
    this.title,
    required this.items,
  });

  factory PdfData.fromJson(Map<String, dynamic> json) =>
      _$PdfDataFromJson(json);

  Map<String, dynamic> toJson() => _$PdfDataToJson(this);

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'items')
  final List<GroceryItem>? items;
}
