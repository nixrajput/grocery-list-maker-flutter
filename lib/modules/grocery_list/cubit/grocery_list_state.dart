part of 'grocery_list_cubit.dart';

enum GroceryListStatus { initial, loading, success, failure }

extension GroceryListStatusX on GroceryListStatus {
  bool get isInitial => this == GroceryListStatus.initial;
  bool get isLoading => this == GroceryListStatus.loading;
  bool get isSuccess => this == GroceryListStatus.success;
  bool get isFailure => this == GroceryListStatus.failure;
}

@JsonSerializable()
class GroceryListState extends Equatable {
  GroceryListState({
    this.status = GroceryListStatus.initial,
    List<GroceryList>? groceryLists,
    String? errorMessage,
  })  : groceryLists = groceryLists ?? [],
        errorMessage = errorMessage ?? '';

  factory GroceryListState.fromJson(Map<String, dynamic> json) =>
      _$GroceryListStateFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListStateToJson(this);

  final GroceryListStatus status;
  final List<GroceryList> groceryLists;
  final String errorMessage;

  GroceryListState copyWith({
    GroceryListStatus? status,
    List<GroceryList>? groceryLists,
    String? errorMessage,
  }) {
    return GroceryListState(
      status: status ?? this.status,
      groceryLists: groceryLists ?? this.groceryLists,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, groceryLists, errorMessage];
}
