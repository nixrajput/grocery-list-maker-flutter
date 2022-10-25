// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroceryListCWProxy {
  GroceryList createdAt(DateTime createdAt);

  GroceryList id(String id);

  GroceryList itemsCount(int? itemsCount);

  GroceryList title(String title);

  GroceryList updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GroceryList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GroceryList(...).copyWith(id: 12, name: "My name")
  /// ````
  GroceryList call({
    DateTime? createdAt,
    String? id,
    int? itemsCount,
    String? title,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGroceryList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGroceryList.copyWith.fieldName(...)`
class _$GroceryListCWProxyImpl implements _$GroceryListCWProxy {
  final GroceryList _value;

  const _$GroceryListCWProxyImpl(this._value);

  @override
  GroceryList createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  GroceryList id(String id) => this(id: id);

  @override
  GroceryList itemsCount(int? itemsCount) => this(itemsCount: itemsCount);

  @override
  GroceryList title(String title) => this(title: title);

  @override
  GroceryList updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GroceryList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GroceryList(...).copyWith(id: 12, name: "My name")
  /// ````
  GroceryList call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? itemsCount = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return GroceryList(
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      itemsCount: itemsCount == const $CopyWithPlaceholder()
          ? _value.itemsCount
          // ignore: cast_nullable_to_non_nullable
          : itemsCount as int?,
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

extension $GroceryListCopyWith on GroceryList {
  /// Returns a callable class that can be used as follows: `instanceOfGroceryList.copyWith(...)` or like so:`instanceOfGroceryList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroceryListCWProxy get copyWith => _$GroceryListCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryListAdapter extends TypeAdapter<GroceryList> {
  @override
  final int typeId = 1;

  @override
  GroceryList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroceryList(
      id: fields[0] as String,
      title: fields[1] as String,
      itemsCount: fields[2] as int?,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GroceryList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.itemsCount)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroceryList _$GroceryListFromJson(Map<String, dynamic> json) => GroceryList(
      id: json['id'] as String,
      title: json['title'] as String,
      itemsCount: json['itemsCount'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GroceryListToJson(GroceryList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'itemsCount': instance.itemsCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
