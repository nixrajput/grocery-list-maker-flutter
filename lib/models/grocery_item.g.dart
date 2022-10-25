// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroceryItemCWProxy {
  GroceryItem createdAt(DateTime createdAt);

  GroceryItem description(String? description);

  GroceryItem id(String id);

  GroceryItem listId(String listId);

  GroceryItem quantity(String? quantity);

  GroceryItem title(String title);

  GroceryItem updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GroceryItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GroceryItem(...).copyWith(id: 12, name: "My name")
  /// ````
  GroceryItem call({
    DateTime? createdAt,
    String? description,
    String? id,
    String? listId,
    String? quantity,
    String? title,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGroceryItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGroceryItem.copyWith.fieldName(...)`
class _$GroceryItemCWProxyImpl implements _$GroceryItemCWProxy {
  final GroceryItem _value;

  const _$GroceryItemCWProxyImpl(this._value);

  @override
  GroceryItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  GroceryItem description(String? description) =>
      this(description: description);

  @override
  GroceryItem id(String id) => this(id: id);

  @override
  GroceryItem listId(String listId) => this(listId: listId);

  @override
  GroceryItem quantity(String? quantity) => this(quantity: quantity);

  @override
  GroceryItem title(String title) => this(title: title);

  @override
  GroceryItem updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GroceryItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GroceryItem(...).copyWith(id: 12, name: "My name")
  /// ````
  GroceryItem call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? listId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return GroceryItem(
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      listId: listId == const $CopyWithPlaceholder() || listId == null
          ? _value.listId
          // ignore: cast_nullable_to_non_nullable
          : listId as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as String?,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $GroceryItemCopyWith on GroceryItem {
  /// Returns a callable class that can be used as follows: `instanceOfGroceryItem.copyWith(...)` or like so:`instanceOfGroceryItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroceryItemCWProxy get copyWith => _$GroceryItemCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryItemAdapter extends TypeAdapter<GroceryItem> {
  @override
  final int typeId = 2;

  @override
  GroceryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroceryItem(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[3] as String?,
      quantity: fields[4] as String?,
      listId: fields[2] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GroceryItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.listId)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroceryItem _$GroceryItemFromJson(Map<String, dynamic> json) => GroceryItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      quantity: json['quantity'] as String?,
      listId: json['listId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GroceryItemToJson(GroceryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'listId': instance.listId,
      'description': instance.description,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
