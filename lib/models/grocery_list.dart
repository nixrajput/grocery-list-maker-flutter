import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grocery_list.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: 1)
class GroceryList extends HiveObject {
  GroceryList({
    required this.id,
    required this.title,
    this.itemsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroceryList.fromJson(Map<String, dynamic> json) =>
      _$GroceryListFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListToJson(this);

  @JsonKey(name: 'id')
  @HiveField(0)
  final String id;

  @JsonKey(name: 'title')
  @HiveField(1)
  final String title;

  @JsonKey(name: 'itemsCount')
  @HiveField(2)
  final int? itemsCount;

  @JsonKey(name: 'createdAt')
  @HiveField(3)
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(4)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'id: $id, title: $title, createdAt: ${createdAt.toIso8601String()}, updatedAt: ${updatedAt.toIso8601String()}';
  }
}
