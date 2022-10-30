import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grocery_item.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: 2)
class GroceryItem extends HiveObject {
  GroceryItem({
    required this.id,
    required this.title,
    this.description,
    this.quantity,
    required this.listId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroceryItem.fromJson(Map<String, dynamic> json) =>
      _$GroceryItemFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryItemToJson(this);

  @JsonKey(name: 'id')
  @HiveField(0)
  final String id;

  @JsonKey(name: 'title')
  @HiveField(1)
  final String title;

  @JsonKey(name: 'listId')
  @HiveField(2)
  final String listId;

  @JsonKey(name: 'description')
  @HiveField(3)
  final String? description;

  @JsonKey(name: 'quantity')
  @HiveField(4)
  final String? quantity;

  @JsonKey(name: 'createdAt')
  @HiveField(5)
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(6)
  final DateTime updatedAt;

  String get quantityOrEmpty => quantity ?? '';
  String get descriptionOrEmpty => description ?? '';

  String getRowDescription(int rowIndex, int itemIndex) {
    switch (rowIndex) {
      case 0:
        return '${itemIndex + 1}.';
      case 1:
        return '$title\n$descriptionOrEmpty';
      case 2:
        return quantityOrEmpty;
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'title: $title, createdAt: ${createdAt.toIso8601String()}, updatedAt: ${updatedAt.toIso8601String()}';
  }
}
