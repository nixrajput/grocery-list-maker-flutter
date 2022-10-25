import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/repository/grocery_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grocery_item_cubit.g.dart';
part 'grocery_item_state.dart';

class GroceryItemCubit extends Cubit<GroceryItemState> {
  GroceryItemCubit(this._groceryRepository) : super(GroceryItemState());

  final GroceryRepository _groceryRepository;

  Future<void> getGroceryItems(String listId) async {
    emit(state.copyWith(status: GroceryItemStatus.loading));

    try {
      final data = await _groceryRepository.getAllGroceryItems(listId);

      emit(state.copyWith(
        status: GroceryItemStatus.success,
        groceryItems: data,
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryItemStatus.failure));
    }
  }

  Future<void> addGroceryItem({
    required String listId,
    required String title,
    String? description,
    String? quantity,
  }) async {
    emit(state.copyWith(status: GroceryItemStatus.loading));

    try {
      final data = await _groceryRepository.addGroceryItem(
        listId: listId,
        title: title,
        description: description,
        quantity: quantity,
      );

      emit(state.copyWith(
        status: GroceryItemStatus.success,
        groceryItems: [...state.groceryItems, data],
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryItemStatus.failure));
    }
  }

  Future<void> updateGroceryItem(
    String id, {
    String? title,
    String? description,
    String? quantity,
  }) async {
    emit(state.copyWith(status: GroceryItemStatus.loading));

    try {
      final data = await _groceryRepository.updateGroceryItem(
        id,
        title: title,
        description: description,
        quantity: quantity,
      );

      if (data == null) {
        emit(state.copyWith(
          status: GroceryItemStatus.failure,
          errorMessage: 'Grocery item not found',
        ));
        return;
      }

      emit(state.copyWith(
        status: GroceryItemStatus.success,
        groceryItems:
            state.groceryItems.map((e) => e.id == data.id ? data : e).toList(),
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryItemStatus.failure));
    }
  }

  Future<void> deleteGroceryItem(String id, String listId) async {
    emit(state.copyWith(status: GroceryItemStatus.loading));

    try {
      await _groceryRepository.deleteGroceryItem(id, listId);

      emit(state.copyWith(
        status: GroceryItemStatus.success,
        groceryItems:
            state.groceryItems.where((element) => element.id != id).toList(),
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryItemStatus.failure));
    }
  }
}
