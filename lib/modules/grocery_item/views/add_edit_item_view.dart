import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/global_widgets/unfocus_widget.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/modules/grocery_item/cubit/grocery_item_cubit.dart';
import 'package:grocery_list_maker/modules/grocery_list/cubit/grocery_list_cubit.dart';

class AddEditItemView extends StatefulWidget {
  final GroceryItem? initialItem;
  final String groceryListId;

  const AddEditItemView({
    Key? key,
    this.initialItem,
    required this.groceryListId,
  }) : super(key: key);

  @override
  State<AddEditItemView> createState() => _AddEditItemViewState();
}

class _AddEditItemViewState extends State<AddEditItemView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _titleTextController;
  TextEditingController? _descTextController;
  TextEditingController? _quantityTextController;

  String? get _groceryListId => widget.groceryListId;

  @override
  void initState() {
    super.initState();
    if (widget.initialItem != null) {
      _titleTextController =
          TextEditingController(text: widget.initialItem?.title);
      _descTextController =
          TextEditingController(text: widget.initialItem?.description);
      _quantityTextController =
          TextEditingController(text: widget.initialItem?.quantity);
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
                _titleTextController!.text != widget.initialItem?.title)) {
          dirty = true;
        } else if ((widget.initialItem == null &&
                _descTextController!.text.isNotEmpty) ||
            (widget.initialItem != null &&
                _descTextController!.text != widget.initialItem?.description)) {
          dirty = true;
        } else if ((widget.initialItem == null &&
                _quantityTextController!.text.isNotEmpty) ||
            (widget.initialItem != null &&
                _quantityTextController!.text !=
                    widget.initialItem?.quantity)) {
          dirty = true;
        }

        if (dirty) {
          _showBackDialog();
        }
        return true;
      },
      child: UnFocusWidget(
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildAppBar(context),
                      const SizedBox(height: 16.0),
                      _buildBody(context),
                    ],
                  ),
                  Positioned(
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                    child: _buildAddButton(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          if (widget.initialItem == null) {
            await BlocProvider.of<GroceryItemCubit>(context)
                .addGroceryItem(
              listId: _groceryListId!,
              title: _titleTextController!.text,
              description: _descTextController!.text,
              quantity: _quantityTextController!.text,
            )
                .then((_) {
              context.read<GroceryListCubit>().getGroceryLists();
              Navigator.pop(context, true);
            });
          } else {
            await BlocProvider.of<GroceryItemCubit>(context)
                .updateGroceryItem(
              widget.initialItem!.id,
              title: _titleTextController!.text,
              description: _descTextController!.text,
              quantity: _quantityTextController!.text,
            )
                .then((_) {
              Navigator.pop(context, true);
            });
          }
        }
      },
      child: Container(
        height: 56.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'Save'.toUpperCase(),
            style: const TextStyle(
              color: lightColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleTextController,
                    textCapitalization: TextCapitalization.words,
                    validator: (val) =>
                        val!.isNotEmpty ? null : 'Title must not be empty',
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    controller: _quantityTextController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    controller: _descTextController,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              var dirty = false;
              if ((widget.initialItem == null &&
                      _titleTextController!.text.isNotEmpty) ||
                  (widget.initialItem != null &&
                      _titleTextController!.text !=
                          widget.initialItem?.title)) {
                dirty = true;
              }

              if (dirty == true) {
                _showBackDialog();
              } else {
                Navigator.pop(context, true);
              }
            },
            child: const Icon(
              Icons.arrow_back,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            widget.initialItem != null ? "Edit Item" : "Add Item",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showBackDialog() async {
    return await showDialog(
        context: context,
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
        });
  }
}