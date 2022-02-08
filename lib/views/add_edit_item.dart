// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/main.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

class AddEditItemPage extends StatefulWidget {
  final GroceryItem? initialItem;
  final int groceryListId;

  const AddEditItemPage({
    Key? key,
    this.initialItem,
    required this.groceryListId,
  }) : super(key: key);

  @override
  State<AddEditItemPage> createState() => _AddEditItemPageState();
}

class _AddEditItemPageState extends State<AddEditItemPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _titleTextController;
  TextEditingController? _descTextController;
  TextEditingController? _quantityTextController;

  int? get _groceryItemId => widget.initialItem?.id.v;

  int? get _groceryListId => widget.groceryListId;

  Future save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await groceryProvider.saveGroceryItem(GroceryItem()
        ..id.v = _groceryItemId
        ..title.v = _titleTextController!.text
        ..description.v = _descTextController!.text
        ..quantity.v = _quantityTextController!.text
        ..listId.v = _groceryListId
        ..addedAt.v = DateTime.now().toIso8601String());
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialItem != null) {
      _titleTextController =
          TextEditingController(text: widget.initialItem?.title.v);
      _descTextController =
          TextEditingController(text: widget.initialItem?.description.v);
      _quantityTextController =
          TextEditingController(text: widget.initialItem?.quantity.v);
    } else {
      _titleTextController = TextEditingController(text: null);
      _descTextController = TextEditingController(text: null);
      _quantityTextController = TextEditingController(text: null);
    }
  }

  @override
  void dispose() {
    _titleTextController?.dispose();
    _descTextController?.dispose();
    _quantityTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        var dirty = false;
        if ((widget.initialItem == null &&
                _titleTextController!.text.isNotEmpty) ||
            (widget.initialItem != null &&
                _titleTextController!.text != widget.initialItem?.title.v)) {
          dirty = true;
        } else if ((widget.initialItem == null &&
                _descTextController!.text.isNotEmpty) ||
            (widget.initialItem != null &&
                _descTextController!.text !=
                    widget.initialItem?.description.v)) {
          dirty = true;
        } else if ((widget.initialItem == null &&
                _quantityTextController!.text.isNotEmpty) ||
            (widget.initialItem != null &&
                _quantityTextController!.text !=
                    widget.initialItem?.quantity.v)) {
          dirty = true;
        }

        if (dirty) {
          return await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Discard changes?"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const [
                            Text("Content has changed."),
                            SizedBox(height: 16.0),
                            Text("Tap CONTINUE to discard your changes."),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx, true);
                            Navigator.pop(context, true);
                          },
                          child: const Text('CONTINUE'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx, false);
                          },
                          child: const Text('CANCEL'),
                        ),
                      ],
                    );
                  }) ??
              false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 16.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () async {
                              var dirty = false;
                              if ((widget.initialItem == null &&
                                      _titleTextController!.text.isNotEmpty) ||
                                  (widget.initialItem != null &&
                                      _titleTextController!.text !=
                                          widget.initialItem?.title.v)) {
                                dirty = true;
                              } else if ((widget.initialItem == null &&
                                      _descTextController!.text.isNotEmpty) ||
                                  (widget.initialItem != null &&
                                      _descTextController!.text !=
                                          widget.initialItem?.description.v)) {
                                dirty = true;
                              } else if ((widget.initialItem == null &&
                                      _quantityTextController!
                                          .text.isNotEmpty) ||
                                  (widget.initialItem != null &&
                                      _quantityTextController!.text !=
                                          widget.initialItem?.quantity.v)) {
                                dirty = true;
                              }

                              if (dirty) {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text("Discard changes?"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const [
                                              Text("Content has changed."),
                                              SizedBox(height: 16.0),
                                              Text(
                                                "Tap CONTINUE to discard your changes.",
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx, true);
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text('CONTINUE'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx, false);
                                            },
                                            child: const Text('CANCEL'),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                Navigator.pop(context, true);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 28.0,
                            ),
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          widget.initialItem != null ? "Edit Item" : "Add Item",
                          style: GoogleFonts.rowdies(
                            textStyle: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                ),
                                controller: _titleTextController,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) => val!.isNotEmpty
                                    ? null
                                    : 'Title must not be empty',
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                ),
                                controller: _descTextController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                ),
                                controller: _quantityTextController,
                                validator: (val) => val!.isNotEmpty
                                    ? null
                                    : 'Quantity must not be empty',
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 64.0),
                              ElevatedButton(
                                onPressed: save,
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(deviceSize.width, 40.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
