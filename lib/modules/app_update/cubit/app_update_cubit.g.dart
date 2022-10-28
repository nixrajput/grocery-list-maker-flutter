// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateState _$AppUpdateStateFromJson(Map<String, dynamic> json) =>
    AppUpdateState(
      status: $enumDecodeNullable(_$AppUpdateStatusEnumMap, json['status']) ??
          AppUpdateStatus.initial,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$AppUpdateStateToJson(AppUpdateState instance) =>
    <String, dynamic>{
      'status': _$AppUpdateStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
    };

const _$AppUpdateStatusEnumMap = {
  AppUpdateStatus.initial: 'initial',
  AppUpdateStatus.loading: 'loading',
  AppUpdateStatus.success: 'success',
  AppUpdateStatus.failure: 'failure',
};
