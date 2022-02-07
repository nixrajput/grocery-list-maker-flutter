// ignore_for_file: strict_raw_type

import 'package:grocery_list_maker/models/constant.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

GroceryItem snapshotToGroceryItem(Map<String, Object?> snapshot) {
  return GroceryItem()..fromMap(snapshot);
}

GroceryList snapshotToGroceryList(Map<String, Object?> snapshot) {
  return GroceryList()..fromMap(snapshot);
}

class GroceryItems extends ListBase<GroceryItem> {
  final List<Map<String, Object?>> list;
  late List<GroceryItem?> _cacheItems;

  GroceryItems(this.list) {
    _cacheItems = List.generate(list.length, (index) => null);
  }

  @override
  GroceryItem operator [](int index) {
    return _cacheItems[index] ??= snapshotToGroceryItem(list[index]);
  }

  @override
  int get length => list.length;

  @override
  void operator []=(int index, GroceryItem? value) => throw 'read-only';

  @override
  set length(int newLength) => throw 'read-only';
}

class GroceryListItems extends ListBase<GroceryList> {
  final List<Map<String, Object?>> list;
  late List<GroceryList?> _cacheItems;

  GroceryListItems(this.list) {
    _cacheItems = List.generate(list.length, (index) => null);
  }

  @override
  GroceryList operator [](int index) {
    return _cacheItems[index] ??= snapshotToGroceryList(list[index]);
  }

  @override
  int get length => list.length;

  @override
  void operator []=(int index, GroceryList? value) => throw 'read-only';

  @override
  set length(int newLength) => throw 'read-only';
}

class GroceryProvider {
  final lock = Lock(reentrant: true);
  final DatabaseFactory databaseFactory;
  final _updateTriggerController = StreamController<bool>.broadcast();
  Database? db;

  GroceryProvider(this.databaseFactory);

  Future openPath(String path) async {
    db = await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: kVersion1,
            onCreate: (db, version) async {
              await _createDb(db);
            },
            onUpgrade: (db, oldVersion, newVersion) async {
              if (oldVersion < newVersion) {
                await _createDb(db);
              }
            }));
  }

  void _triggerUpdate() {
    _updateTriggerController.sink.add(true);
  }

  Future<Database?> get ready async => db ??= await lock.synchronized(() async {
        if (db == null) {
          await open();
        }
        return db;
      });

  Future _createDb(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $tableGroceryItems');
    await db.execute('DROP TABLE IF EXISTS $tableGroceryLists');
    await db.execute(
        'CREATE TABLE $tableGroceryItems($columnId INTEGER PRIMARY KEY, '
        '$columnTitle TEXT, $columnDescription TEXT, $columnQuantity TEXT, '
        '$columnListId INTEGER, $columnAddedAt TEXT)');
    await db.execute(
        'CREATE TABLE $tableGroceryLists($columnId INTEGER PRIMARY KEY, '
        '$columnTitle TEXT, $columnDescription TEXT, $columnAddedAt DATE)');
    await db.execute(
        'CREATE INDEX ItemAddedAt ON $tableGroceryItems ($columnAddedAt)');
    await db.execute(
        'CREATE INDEX ListAddedAt ON $tableGroceryLists ($columnAddedAt)');
  }

  Future open() async {
    await openPath(await fixPath(dbName));
  }

  Future<String> fixPath(String path) async => path;

  // Get Grocery Item
  Future<GroceryItem?> getGroceryItem(int? id) async {
    var list = (await db!.query(
      tableGroceryItems,
      columns: [
        columnId,
        columnTitle,
        columnDescription,
        columnQuantity,
        columnListId,
        columnAddedAt,
      ],
      where: '$columnId = ?',
      whereArgs: <Object?>[id],
    ));

    if (list.isNotEmpty) {
      return GroceryItem()..fromMap(list.first);
    }
    return null;
  }

  // Get Grocery List
  Future<GroceryList?> getGroceryListItem(int? id) async {
    var list = (await db!.query(
      tableGroceryLists,
      columns: [
        columnId,
        columnTitle,
        columnDescription,
        columnAddedAt,
      ],
      where: '$columnId = ?',
      whereArgs: <Object?>[id],
    ));

    if (list.isNotEmpty) {
      return GroceryList()..fromMap(list.first);
    }
    return null;
  }

  // Save or Edit Grocery Item
  Future _saveGroceryItem(DatabaseExecutor? db, GroceryItem updateItem) async {
    if (updateItem.id.v != null) {
      await db!.update(tableGroceryItems, updateItem.toMap(),
          where: '$columnId = ?', whereArgs: <Object?>[updateItem.id.v]);
    } else {
      updateItem.id.v = await db!.insert(tableGroceryItems, updateItem.toMap());
    }
  }

  Future saveGroceryItem(GroceryItem updateItem) async {
    await _saveGroceryItem(db, updateItem);
    _triggerUpdate();
  }

  // Save or Edit Grocery List
  Future _saveGroceryListItem(
      DatabaseExecutor? db, GroceryList updateItem) async {
    if (updateItem.id.v != null) {
      await db!.update(tableGroceryLists, updateItem.toMap(),
          where: '$columnId = ?', whereArgs: <Object?>[updateItem.id.v]);
    } else {
      updateItem.id.v = await db!.insert(tableGroceryLists, updateItem.toMap());
    }
  }

  Future saveGroceryListItem(GroceryList updateItem) async {
    await _saveGroceryListItem(db, updateItem);
    _triggerUpdate();
  }

  // Delete Grocery Item
  Future<void> deleteGroceryItem(int? id) async {
    await db!.delete(tableGroceryItems,
        where: '$columnId = ?', whereArgs: <Object?>[id]);
    _triggerUpdate();
  }

  // Delete Grocery List
  Future<void> deleteGroceryListItem(int? id) async {
    await db!.delete(tableGroceryItems,
        where: '$columnListId = ?', whereArgs: <Object?>[id]);
    await db!.delete(tableGroceryLists,
        where: '$columnId = ?', whereArgs: <Object?>[id]);
    _triggerUpdate();
  }

  var groceryItemsTransformer =
      StreamTransformer<Map<String, Object?>, GroceryItem?>.fromHandlers(
          handleData: (snapshot, sink) {
    sink.add(snapshotToGroceryItem(snapshot));
  });

  var groceryListItemsTransformer =
      StreamTransformer<Map<String, Object?>, GroceryList?>.fromHandlers(
          handleData: (snapshot, sink) {
    sink.add(snapshotToGroceryList(snapshot));
  });

  // Listen Grocery Items Snapshot
  Stream<List<GroceryItem>> onGroceryItems({int? listId}) {
    late StreamController<GroceryItems> controller;
    StreamSubscription<dynamic>? _triggerSubscription;

    Future<void> sendUpdate() async {
      var items = await getListGroceryItems(listId);
      if (!controller.isClosed) {
        controller.add(items);
      }
    }

    controller = StreamController<GroceryItems>(onListen: () {
      sendUpdate();

      _triggerSubscription = _updateTriggerController.stream.listen(
        (_) {
          sendUpdate();
        },
      );
    }, onCancel: () {
      _triggerSubscription?.cancel();
    });
    return controller.stream;
  }

  // Listen Grocery List Items Snapshot
  Stream<List<GroceryList>> onGroceryListItems() {
    late StreamController<GroceryListItems> controller;
    StreamSubscription<dynamic>? _triggerSubscription;

    Future<void> sendUpdate() async {
      var items = await getListGroceryListItems();
      if (!controller.isClosed) {
        controller.add(items);
      }
    }

    controller = StreamController<GroceryListItems>(onListen: () {
      sendUpdate();

      _triggerSubscription = _updateTriggerController.stream.listen(
        (_) {
          sendUpdate();
        },
      );
    }, onCancel: () {
      _triggerSubscription?.cancel();
    });
    return controller.stream;
  }

  // Listen Grocery Item Snapshot
  Stream<GroceryItem?> onGroceryItem(int? id) {
    late StreamController<GroceryItem?> controller;
    StreamSubscription<dynamic>? _triggerSubscription;

    Future<void> sendUpdate() async {
      var item = await getGroceryItem(id);
      if (!controller.isClosed) {
        controller.add(item);
      }
    }

    controller = StreamController<GroceryItem?>(onListen: () {
      sendUpdate();

      _triggerSubscription = _updateTriggerController.stream.listen(
        (_) {
          sendUpdate();
        },
      );
    }, onCancel: () {
      _triggerSubscription?.cancel();
    });
    return controller.stream;
  }

  // Listen Grocery List Item Snapshot
  Stream<GroceryList?> onGroceryListItem(int? id) {
    late StreamController<GroceryList?> controller;
    StreamSubscription<dynamic>? _triggerSubscription;

    Future<void> sendUpdate() async {
      var item = await getGroceryListItem(id);
      if (!controller.isClosed) {
        controller.add(item);
      }
    }

    controller = StreamController<GroceryList?>(onListen: () {
      sendUpdate();

      _triggerSubscription = _updateTriggerController.stream.listen(
        (_) {
          sendUpdate();
        },
      );
    }, onCancel: () {
      _triggerSubscription?.cancel();
    });
    return controller.stream;
  }

  // Get Grocery Items
  Future<GroceryItems> getListGroceryItems(
    int? listId, {
    int? offset,
    int? limit,
    bool? descending,
  }) async {
    List<Map<String, Object?>> list;

    if (listId != null) {
      list = (await db!.query(
        tableGroceryItems,
        columns: [
          columnId,
          columnTitle,
          columnDescription,
          columnQuantity,
          columnListId,
          columnAddedAt
        ],
        where: '$columnListId = ?',
        whereArgs: <Object?>[listId],
        orderBy: '$columnAddedAt ${(descending ?? false) ? 'ASC' : 'DESC'}',
        limit: limit,
        offset: offset,
      ));
    } else {
      list = (await db!.query(
        tableGroceryItems,
        columns: [
          columnId,
          columnTitle,
          columnDescription,
          columnQuantity,
          columnListId,
          columnAddedAt
        ],
        orderBy: '$columnAddedAt ${(descending ?? false) ? 'ASC' : 'DESC'}',
        limit: limit,
        offset: offset,
      ));
    }

    return GroceryItems(list);
  }

  // Get Grocery List Items
  Future<GroceryListItems> getListGroceryListItems(
      {int? offset, int? limit, bool? descending}) async {
    var list = (await db!.query(
      tableGroceryLists,
      columns: [columnId, columnTitle, columnDescription, columnAddedAt],
      orderBy: '$columnAddedAt ${(descending ?? false) ? 'ASC' : 'DESC'}',
      limit: limit,
      offset: offset,
    ));
    return GroceryListItems(list);
  }

  // Clear All Grocery Items
  Future clearAllGroceryItems() async {
    await db!.delete(tableGroceryItems);
    _triggerUpdate();
  }

  // Clear All Grocery Lists
  Future clearAllGroceryLists() async {
    await db!.delete(tableGroceryLists);
    _triggerUpdate();
  }

  Future close() async {
    await db!.close();
  }

  Future deleteDb() async {
    await databaseFactory.deleteDatabase(await fixPath(dbName));
  }
}
