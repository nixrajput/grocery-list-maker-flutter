// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_list_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroceryListState _$GroceryListStateFromJson(Map<String, dynamic> json) =>
    GroceryListState(
      status: $enumDecodeNullable(_$GroceryListStatusEnumMap, json['status']) ??
          GroceryListStatus.initial,
      groceryLists: (json['groceryLists'] as List<dynamic>?)
          ?.map((e) => GroceryList.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$GroceryListStateToJson(GroceryListState instance) =>
    <String, dynamic>{
      'status': _$GroceryListStatusEnumMap[instance.status]!,
      'groceryLists': instance.groceryLists,
      'errorMessage': instance.errorMessage,
    };

const _$GroceryListStatusEnumMap = {
  GroceryListStatus.initial: 'initial',
  GroceryListStatus.loading: 'loading',
  GroceryListStatus.success: 'success',
  GroceryListStatus.failure: 'failure',
};
