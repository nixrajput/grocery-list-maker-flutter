import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/global_widgets/unfocus_widget.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/modules/grocery_list/cubit/grocery_list_cubit.dart';

class AddEditListView extends StatefulWidget {
  final GroceryList? initialItem;

  const AddEditListView({Key? key, this.initialItem}) : super(key: key);

  @override
  State<AddEditListView> createState() => AddEditListViewState();
}

class AddEditListViewState extends State<AddEditListView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _titleTextController;

  @override
  void initState() {
    super.initState();
    if (widget.initialItem != null) {
      _titleTextController =
          TextEditingController(text: widget.initialItem?.title);
    } else {
      _titleTextController = TextEditingController(text: null);
    }
  }

  @override
  void dispose() {
    _titleTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return UnFocusWidget(
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
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          if (widget.initialItem == null) {
            await BlocProvider.of<GroceryListCubit>(context)
                .addGroceryList(_titleTextController!.text)
                .then((_) {
              Navigator.pop(context, true);
            });
          } else {
            await BlocProvider.of<GroceryListCubit>(context)
                .updateGroceryList(
              widget.initialItem!.id,
              _titleTextController!.text,
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
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
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
            onTap: () => Navigator.pop(context, true),
            child: const Icon(
              Icons.arrow_back,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            widget.initialItem != null ? "Edit List" : "Add New List",
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
}
