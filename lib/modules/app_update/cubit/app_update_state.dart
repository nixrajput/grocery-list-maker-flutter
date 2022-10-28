part of 'app_update_cubit.dart';

enum AppUpdateStatus { initial, loading, success, failure }

extension AppUpdateStatusX on AppUpdateStatus {
  bool get isInitial => this == AppUpdateStatus.initial;
  bool get isLoading => this == AppUpdateStatus.loading;
  bool get isSuccess => this == AppUpdateStatus.success;
  bool get isFailure => this == AppUpdateStatus.failure;
}

@JsonSerializable()
class AppUpdateState extends Equatable {
  const AppUpdateState({
    this.status = AppUpdateStatus.initial,
    String? errorMessage,
  }) : errorMessage = errorMessage ?? '';

  factory AppUpdateState.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppUpdateStateToJson(this);

  final AppUpdateStatus status;
  final String errorMessage;

  AppUpdateState copyWith({
    AppUpdateStatus? status,
    String? errorMessage,
  }) {
    return AppUpdateState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
