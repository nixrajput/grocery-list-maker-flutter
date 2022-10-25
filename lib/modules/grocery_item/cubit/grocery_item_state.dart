part of 'grocery_item_cubit.dart';

enum GroceryItemStatus { initial, loading, success, failure }

extension GroceryItemStatusX on GroceryItemStatus {
  bool get isInitial => this == GroceryItemStatus.initial;
  bool get isLoading => this == GroceryItemStatus.loading;
  bool get isSuccess => this == GroceryItemStatus.success;
  bool get isFailure => this == GroceryItemStatus.failure;
}

@JsonSerializable()
class GroceryItemState extends Equatable {
  GroceryItemState({
    this.status = GroceryItemStatus.initial,
    List<GroceryItem>? groceryItems,
    String? errorMessage,
  })  : groceryItems = groceryItems ?? [],
        errorMessage = errorMessage ?? '';

  factory GroceryItemState.fromJson(Map<String, dynamic> json) =>
      _$GroceryItemStateFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryItemStateToJson(this);

  final GroceryItemStatus status;
  final List<GroceryItem> groceryItems;
  final String errorMessage;

  GroceryItemState copyWith({
    GroceryItemStatus? status,
    List<GroceryItem>? groceryItems,
    String? errorMessage,
  }) {
    return GroceryItemState(
      status: status ?? this.status,
      groceryItems: groceryItems ?? this.groceryItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, groceryItems, errorMessage];
}
