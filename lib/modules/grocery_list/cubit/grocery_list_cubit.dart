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
    } on Exception {
      emit(state.copyWith(status: GroceryListStatus.failure));
    }
  }

  Future<void> addGroceryList(String title) async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      final data = await _groceryRepository.addGroceryList(title);

      emit(state.copyWith(
        status: GroceryListStatus.success,
        groceryLists: [...state.groceryLists, data],
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryListStatus.failure));
    }
  }

  Future<void> updateGroceryList(String id, String title) async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      final data = await _groceryRepository.updateGroceryList(id, title: title);

      if (data == null) {
        emit(state.copyWith(
          status: GroceryListStatus.failure,
          errorMessage: 'Grocery list not found',
        ));
        return;
      }

      emit(state.copyWith(
        status: GroceryListStatus.success,
        groceryLists:
            state.groceryLists.map((e) => e.id == data.id ? data : e).toList(),
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryListStatus.failure));
    }
  }

  Future<void> deleteGroceryList(String id) async {
    emit(state.copyWith(status: GroceryListStatus.loading));

    try {
      await _groceryRepository.deleteGroceryList(id);

      emit(state.copyWith(
        status: GroceryListStatus.success,
        groceryLists:
            state.groceryLists.where((element) => element.id != id).toList(),
      ));
    } on Exception {
      emit(state.copyWith(status: GroceryListStatus.failure));
    }
  }
}
