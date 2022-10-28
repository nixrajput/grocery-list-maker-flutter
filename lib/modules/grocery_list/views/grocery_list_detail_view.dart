import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/global_widgets/loading_widget.dart';
import 'package:grocery_list_maker/global_widgets/unfocus_widget.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/modules/grocery_item/cubit/grocery_item_cubit.dart';
import 'package:grocery_list_maker/modules/grocery_item/views/add_edit_item_view.dart';
import 'package:grocery_list_maker/modules/grocery_item/widgets/grocery_item_card.dart';
import 'package:grocery_list_maker/modules/grocery_list/cubit/grocery_list_cubit.dart';
import 'package:grocery_list_maker/modules/pdf/pdf_preview.dart';
import 'package:grocery_list_maker/utils/utility.dart';

class GroceryListDetailView extends StatefulWidget {
  final GroceryList initialItem;

  const GroceryListDetailView({Key? key, required this.initialItem})
      : super(key: key);

  @override
  GroceryListDetailViewState createState() => GroceryListDetailViewState();
}

class GroceryListDetailViewState extends State<GroceryListDetailView> {
  String get _groceryListId => widget.initialItem.id;
  TextEditingController? _nameTextController;
  TextEditingController? _titleTextController;
  TextEditingController? _addressTextController;
  List<GroceryItem>? items;

  String _name = '';
  String _address = '';
  String? _title = '';

  @override
  void dispose() {
    _titleTextController?.dispose();
    _nameTextController?.dispose();
    _addressTextController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<GroceryItemCubit>().getGroceryItems(_groceryListId);
    super.initState();
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
                    const SizedBox(height: 8.0),
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

  Expanded _buildBody(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: BlocConsumer<GroceryItemCubit, GroceryItemState>(
          listener: (_, state) {
            if (state.status.isFailure) {
              AppUtility.showSnackBar(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (_, state) {
            switch (state.status) {
              case GroceryItemStatus.initial:
                return _buildEmptyWidget(deviceSize);
              case GroceryItemStatus.loading:
                return const LoadingWidget();
              case GroceryItemStatus.success:
              case GroceryItemStatus.failure:
                if (state.groceryItems.isEmpty) {
                  return _buildEmptyWidget(deviceSize);
                }
                state.groceryItems
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: state.groceryItems.length,
                  itemBuilder: (_, index) {
                    final groceryItem = state.groceryItems[index];
                    return GroceryItemCard(
                      item: groceryItem,
                      onDelete: () async {
                        await context
                            .read<GroceryItemCubit>()
                            .deleteGroceryItem(
                              groceryItem.id,
                              groceryItem.listId,
                            )
                            .then((_) async {
                          await context
                              .read<GroceryListCubit>()
                              .getGroceryLists();
                        });
                      },
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  Column _buildEmptyWidget(Size deviceSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/empty_cart.svg",
          width: deviceSize.width * 0.25,
          height: deviceSize.height * 0.25,
        ),
        const SizedBox(height: 20.0),
        const Center(
          child: Text(
            'Start adding your grocery items',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            widget.initialItem.title,
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

  Widget _buildAddButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return AddEditItemView(
                      initialItem: null,
                      groceryListId: _groceryListId,
                    );
                  },
                ),
              );
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
                  'Add New Item'.toUpperCase(),
                  style: const TextStyle(
                    color: lightColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _exportDialog(context),
            child: Container(
              height: 56.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade400,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Export'.toUpperCase(),
                  style: const TextStyle(
                    color: lightColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _exportDialog(BuildContext context) {
    AppUtility.showAlertDialog(
      context: context,
      body: ListBody(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            onChanged: (value) {
              setState(() {
                _title = value;
              });
            },
            controller: _titleTextController,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
            controller: _nameTextController,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Address',
            ),
            onChanged: (value) {
              setState(() {
                _address = value;
              });
            },
            controller: _addressTextController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
      title: const Text("Enter Details"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return PdfPreviewView(
                    data: items,
                    name: _name,
                    address: _address,
                    title: _title != '' ? _title : widget.initialItem.title,
                  );
                },
              ),
            );
          },
          child: const Text('CONTINUE'),
        ),
      ],
    );
  }
}
