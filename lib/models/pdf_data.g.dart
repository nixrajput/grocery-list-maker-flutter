// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PdfDataCWProxy {
  PdfData address(String? address);

  PdfData items(List<GroceryItem>? items);

  PdfData name(String? name);

  PdfData title(String? title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PdfData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PdfData(...).copyWith(id: 12, name: "My name")
  /// ````
  PdfData call({
    String? address,
    List<GroceryItem>? items,
    String? name,
    String? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPdfData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPdfData.copyWith.fieldName(...)`
class _$PdfDataCWProxyImpl implements _$PdfDataCWProxy {
  final PdfData _value;

  const _$PdfDataCWProxyImpl(this._value);

  @override
  PdfData address(String? address) => this(address: address);

  @override
  PdfData items(List<GroceryItem>? items) => this(items: items);

  @override
  PdfData name(String? name) => this(name: name);

  @override
  PdfData title(String? title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PdfData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PdfData(...).copyWith(id: 12, name: "My name")
  /// ````
  PdfData call({
    Object? address = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return PdfData(
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<GroceryItem>?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
    );
  }
}

extension $PdfDataCopyWith on PdfData {
  /// Returns a callable class that can be used as follows: `instanceOfPdfData.copyWith(...)` or like so:`instanceOfPdfData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PdfDataCWProxy get copyWith => _$PdfDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdfData _$PdfDataFromJson(Map<String, dynamic> json) => PdfData(
      name: json['name'] as String?,
      address: json['address'] as String?,
      title: json['title'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GroceryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PdfDataToJson(PdfData instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'address': instance.address,
      'items': instance.items,
    };
