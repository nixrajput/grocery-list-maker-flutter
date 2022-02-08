import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/main.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/views/add_edit_item.dart';
import 'package:grocery_list_maker/views/pdf_preview.dart';
import 'package:grocery_list_maker/views/widgets/grocery_item_card.dart';
import 'package:grocery_list_maker/views/widgets/popup_menu_tile.dart';

class ListDetailsPage extends StatefulWidget {
  final GroceryList initialItem;

  const ListDetailsPage({Key? key, required this.initialItem})
      : super(key: key);

  @override
  _ListDetailsPageState createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  int get _groceryListId => widget.initialItem.id.v!;
  TextEditingController? _nameTextController;
  TextEditingController? _addressTextController;
  List<GroceryItem?>? items;

  String _name = '';
  String _address = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28.0,
                        ),
                        padding: const EdgeInsets.all(0.0),
                      ),
                      PopupMenuButton(
                        padding: const EdgeInsets.all(0.0),
                        onSelected: (value) async {
                          if (value == 0) {
                            await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Enter Details"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
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
                                            textCapitalization:
                                                TextCapitalization.words,
                                          ),
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
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx, false);
                                        },
                                        child: const Text('CANCEL'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx, true);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return PdfPreviewPage(
                                                  data: items,
                                                  name: _name,
                                                  address: _address,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text('CONTINUE'),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        itemBuilder: (ctx) {
                          return [
                            const PopupMenuItem(
                              value: 0,
                              child: PopUpMenuTile(
                                title: 'Export PDF',
                                icon: Icons.picture_as_pdf,
                              ),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: PopUpMenuTile(
                                title: 'Delete List',
                                icon: Icons.delete_forever,
                              ),
                            ),
                          ];
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      widget.initialItem.title.v!,
                      style: GoogleFonts.rowdies(
                        textStyle: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
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
                child: StreamBuilder<List<GroceryItem?>>(
                  stream: groceryProvider.onGroceryItems(
                    listId: _groceryListId,
                  ),
                  builder: (ctx, snapshot) {
                    var items = snapshot.data;
                    this.items = items;
                    if (items == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (items.isEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/empty_cart.svg",
                            width: deviceSize.width * 0.75,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "No items. List is empty.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                          )
                        ],
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        var item = items[i]!;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GroceryItemCard(
                              title: item.title.v ?? '',
                              description: item.description.v ?? '',
                              quantity: item.quantity.v ?? '',
                              onEditBtn: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return AddEditItemPage(
                                        initialItem: item,
                                        groceryListId: _groceryListId,
                                      );
                                    },
                                  ),
                                );
                              },
                              onDeleteBtn: () async {
                                if (await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: const Text("Delete Item?"),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const [
                                                  Text(
                                                      "Tap YES to confirm item deletion."),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(ctx, true);
                                                },
                                                child: const Text('YES'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(ctx, false);
                                                },
                                                child: const Text('NO'),
                                              ),
                                            ],
                                          );
                                        }) ??
                                    false) {
                                  await groceryProvider
                                      .deleteGroceryItem(item.id.v);
                                }
                              },
                            ),
                            if (i != (items.length - 1))
                              const SizedBox(height: 8.0),
                          ],
                        );
                      },
                      itemCount: items.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AddEditItemPage(
                initialItem: null,
                groceryListId: _groceryListId,
              );
            }));
          },
          icon: Icon(
            Icons.add,
            size: deviceSize.width * 0.1,
            color: lightColor,
          ),
          padding: const EdgeInsets.all(0.0),
        ),
      ),
    );
  }
}
