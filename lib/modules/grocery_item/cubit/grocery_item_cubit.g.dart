// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_item_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroceryItemState _$GroceryItemStateFromJson(Map<String, dynamic> json) =>
    GroceryItemState(
      status: $enumDecodeNullable(_$GroceryItemStatusEnumMap, json['status']) ??
          GroceryItemStatus.initial,
      groceryItems: (json['groceryItems'] as List<dynamic>?)
          ?.map((e) => GroceryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$GroceryItemStateToJson(GroceryItemState instance) =>
    <String, dynamic>{
      'status': _$GroceryItemStatusEnumMap[instance.status]!,
      'groceryItems': instance.groceryItems,
      'errorMessage': instance.errorMessage,
    };

const _$GroceryItemStatusEnumMap = {
  GroceryItemStatus.initial: 'initial',
  GroceryItemStatus.loading: 'loading',
  GroceryItemStatus.success: 'success',
  GroceryItemStatus.failure: 'failure',
};
