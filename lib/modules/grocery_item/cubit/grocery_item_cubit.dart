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
    } catch (e) {
      emit(state.copyWith(
        status: GroceryItemStatus.failure,
        errorMessage: e.toString(),
        groceryItems: [...state.groceryItems],
      ));
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
      var isExists = await _groceryRepository.checkIfItemAlreadyExistsWithTitle(
          listId, title);

      if (isExists) {
        emit(state.copyWith(
          status: GroceryItemStatus.failure,
          errorMessage: 'Grocery item with this title already exists',
          groceryItems: [...state.groceryItems],
        ));
      } else {
        var item = await _groceryRepository.addGroceryItem(
          listId: listId,
          title: title,
          description: description,
          quantity: quantity,
        );

        emit(state.copyWith(
          status: GroceryItemStatus.success,
          groceryItems: [...state.groceryItems, item],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: GroceryItemStatus.failure,
        errorMessage: e.toString(),
        groceryItems: [...state.groceryItems],
      ));
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
      var tempItem =
          state.groceryItems.firstWhere((element) => element.id == id);
      if (title != null && title.isNotEmpty && title != tempItem.title) {
        var isExists = await _groceryRepository
            .checkIfItemAlreadyExistsWithTitle(tempItem.listId, title);

        if (isExists) {
          emit(state.copyWith(
            status: GroceryItemStatus.failure,
            errorMessage: 'Grocery item with this title already exists',
            groceryItems: [...state.groceryItems],
          ));
          return;
        }
      }

      var item = await _groceryRepository.updateGroceryItem(
        id,
        title: title,
        description: description,
        quantity: quantity,
      );

      if (item != null) {
        var temp = state.groceryItems;
        temp.removeWhere((element) => element.id == id);
        temp.add(item);

        emit(state.copyWith(
          status: GroceryItemStatus.success,
          groceryItems: temp,
        ));
      } else {
        emit(state.copyWith(
          status: GroceryItemStatus.failure,
          errorMessage: 'Grocery item not found',
          groceryItems: [...state.groceryItems],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: GroceryItemStatus.failure,
        errorMessage: e.toString(),
        groceryItems: [...state.groceryItems],
      ));
    }
  }

  Future<void> deleteGroceryItem(String id, String listId) async {
    emit(state.copyWith(status: GroceryItemStatus.loading));

    try {
      await _groceryRepository.deleteGroceryItem(id, listId);

      var temp = state.groceryItems;
      temp.removeWhere((element) => element.id == id);

      emit(state.copyWith(
        status: GroceryItemStatus.success,
        groceryItems: temp,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryItemStatus.failure,
        errorMessage: e.toString(),
        groceryItems: [...state.groceryItems],
      ));
    }
  }

  Future<void> deleteAllGroceryItems(String listId) async {
    emit(state.copyWith(status: GroceryItemStatus.loading));

    try {
      await _groceryRepository.deleteAllGroceryItems(listId);

      emit(state.copyWith(
        status: GroceryItemStatus.success,
        groceryItems: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryItemStatus.failure,
        errorMessage: e.toString(),
        groceryItems: [...state.groceryItems],
      ));
    }
  }
}
