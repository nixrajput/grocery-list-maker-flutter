import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/repository/grocery_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grocery_list_cubit.g.dart';
part 'grocery_list_state.dart';

class GroceryListCubit extends Cubit<GroceryListState> {
  GroceryListCubit(this._groceryRepository) : super(GroceryListState());

  final GroceryRepository _groceryRepository;

  Future<void> getGroceryLists() async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      final data = await _groceryRepository.getAllGroceryLists();

      emit(state.copyWith(
        status: GroceryListStatus.success,
        groceryLists: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryListStatus.failure,
        errorMessage: e.toString(),
        groceryLists: [...state.groceryLists],
      ));
    }
  }

  Future<void> addGroceryList(String title) async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      var isExists =
          await _groceryRepository.checkIfListAlreadyExistsWithTitle(title);

      if (isExists) {
        emit(state.copyWith(
          status: GroceryListStatus.failure,
          errorMessage: 'Grocery list with this title already exists',
          groceryLists: [...state.groceryLists],
        ));
      } else {
        var item = await _groceryRepository.addGroceryList(title);

        emit(state.copyWith(
          status: GroceryListStatus.success,
          groceryLists: [...state.groceryLists, item],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: GroceryListStatus.failure,
        errorMessage: e.toString(),
        groceryLists: [...state.groceryLists],
      ));
    }
  }

  Future<void> updateGroceryList(String id, String title) async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      var isExists =
          await _groceryRepository.checkIfListAlreadyExistsWithTitle(title);

      if (isExists) {
        emit(state.copyWith(
          status: GroceryListStatus.failure,
          errorMessage: 'Grocery list with this title already exists',
          groceryLists: [...state.groceryLists],
        ));
      } else {
        var item = await _groceryRepository.updateGroceryList(id, title: title);

        if (item == null) {
          emit(state.copyWith(
            status: GroceryListStatus.failure,
            errorMessage: 'Grocery list not found',
            groceryLists: [...state.groceryLists],
          ));
        } else {
          var index =
              state.groceryLists.indexWhere((element) => element.id == id);
          var temp = [...state.groceryLists];
          temp[index] = item;

          emit(state.copyWith(
            status: GroceryListStatus.success,
            groceryLists: temp,
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: GroceryListStatus.failure,
        errorMessage: e.toString(),
        groceryLists: [...state.groceryLists],
      ));
    }
  }

  Future<void> deleteGroceryList(String id) async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      await _groceryRepository.deleteGroceryList(id);

      var temp = [...state.groceryLists];
      temp.removeWhere((element) => element.id == id);

      emit(state.copyWith(
        status: GroceryListStatus.success,
        groceryLists: temp,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryListStatus.failure,
        errorMessage: e.toString(),
        groceryLists: [...state.groceryLists],
      ));
    }
  }

  Future<void> deleteAllGroceryLists() async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      await _groceryRepository.deleteAllGroceryLists();

      emit(state.copyWith(
        status: GroceryListStatus.success,
        groceryLists: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryListStatus.failure,
        errorMessage: e.toString(),
        groceryLists: [...state.groceryLists],
      ));
    }
  }
}
