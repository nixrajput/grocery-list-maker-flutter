import 'package:grocery_list_maker/constants/strings.dart';
import 'package:grocery_list_maker/db/hive_services.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/utils/utility.dart';

class GroceryRepository {
  /// [GroceryList] Functions --------------------------------------------------

  Future<List<GroceryList>> getAllGroceryLists() async {
    var hasLength = await HiveServices.hasLength<GroceryList>(groceryLists);
    if (!hasLength) return [];

    var data = await HiveServices.getAll<GroceryList>(groceryLists);
    return data;
  }

  Future<bool> checkIfListAlreadyExistsWithTitle(String title) async {
    var data = await HiveServices.getAll<GroceryList>(groceryLists);

    if (data.isNotEmpty) {
      for (var item in data) {
        if (item.title.toLowerCase() == title.toLowerCase()) return true;
      }
    }

    return false;
  }

  Future<GroceryList> addGroceryList(String title) async {
    var uid = AppUtility.generateUid(16);
    AppUtility.log('groceryListUid: $uid');

    var item = GroceryList(
      id: uid,
      title: title,
      itemsCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await HiveServices.put<GroceryList>(groceryLists, uid, item);
    return item;
  }

  Future<GroceryList?> updateGroceryList(
    String uid, {
    String? title,
    int? itemsCount,
  }) async {
    var item = await HiveServices.get<GroceryList>(groceryLists, uid);

    if (item == null) return null;

    var tempItem = item;

    if (title != null) {
      tempItem = tempItem.copyWith.title(title);
    }
    if (itemsCount != null) {
      tempItem = tempItem.copyWith.itemsCount(itemsCount);
    }
    tempItem = tempItem.copyWith.updatedAt(DateTime.now());

    AppUtility.log('updatedItem: $tempItem');

    await HiveServices.delete<GroceryList>(groceryLists, uid);
    await HiveServices.put<GroceryList>(groceryLists, uid, tempItem);

    return tempItem;
  }

  Future<void> deleteGroceryList(String id) async {
    if (id.isEmpty) {
      AppUtility.log('id is empty');
      return;
    }

    await HiveServices.delete<GroceryList>(groceryLists, id);
  }

  Future<void> deleteAllGroceryLists(String listId) async {
    var hasLength = await HiveServices.hasLength<GroceryList>(groceryLists);
    if (!hasLength) return;

    var data = await HiveServices.getAll<GroceryList>(groceryLists);
    if (data.isEmpty) return;

    for (var item in data) {
      await HiveServices.delete<GroceryList>(groceryLists, item.id);
    }
  }

  /// [GroceryItem] Functions --------------------------------------------------

  Future<List<GroceryItem>> getAllGroceryItems(String listId) async {
    var hasLength = await HiveServices.hasLength<GroceryItem>(groceryItems);
    if (!hasLength) return [];

    var data = await HiveServices.getAll<GroceryItem>(groceryItems);

    var results = data.where((element) => element.listId == listId).toList();
    return results;
  }

  Future<bool> checkIfItemAlreadyExistsWithTitle(
    String listId,
    String title,
  ) async {
    var data = await HiveServices.getAll<GroceryItem>(groceryItems);

    if (data.isNotEmpty) {
      for (var item in data) {
        if (item.listId == listId &&
            item.title.toLowerCase() == title.toLowerCase()) return true;
      }
    }

    return false;
  }

  Future<GroceryItem> addGroceryItem({
    required String listId,
    required String title,
    String? description,
    String? quantity,
  }) async {
    var uid = AppUtility.generateUid(16);
    AppUtility.log('groceryItemUid: $uid');

    var item = GroceryItem(
      id: uid,
      title: title,
      description: description,
      quantity: quantity,
      listId: listId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await HiveServices.put<GroceryItem>(groceryItems, uid, item);
    await updateGroceryList(
      listId,
      itemsCount: (await getAllGroceryItems(listId)).length,
    );
    return item;
  }

  Future<GroceryItem?> updateGroceryItem(
    String uid, {
    String? title,
    String? description,
    String? quantity,
  }) async {
    var item = await HiveServices.get<GroceryItem>(groceryItems, uid);

    if (item == null) return null;

    var tempItem = item;

    if (title != null && title.isNotEmpty) {
      tempItem = tempItem.copyWith.title(title);
    }
    if (description != null && description.isNotEmpty) {
      tempItem = tempItem.copyWith.description(description);
    }
    if (quantity != null && quantity.isNotEmpty) {
      tempItem = tempItem.copyWith.quantity(quantity);
    }

    tempItem = tempItem.copyWith.updatedAt(DateTime.now());

    AppUtility.log('updatedItem: $tempItem');

    await HiveServices.delete<GroceryItem>(groceryItems, uid);
    await HiveServices.put<GroceryItem>(groceryItems, uid, tempItem);

    return tempItem;
  }

  Future<void> deleteGroceryItem(String id, String listId) async {
    if (id.isEmpty) {
      AppUtility.log('id is empty');
      return;
    }

    await HiveServices.delete<GroceryItem>(groceryItems, id);
    await updateGroceryList(
      listId,
      itemsCount: (await getAllGroceryItems(listId)).length,
    );
  }

  Future<void> deleteAllGroceryItems(String listId) async {
    var items = await getAllGroceryItems(listId);
    for (var item in items) {
      await deleteGroceryItem(item.id, listId);
    }
  }
}
