import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/main.dart' show groceryProvider;
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
  TextEditingController? _titleTextController;
  TextEditingController? _addressTextController;
  List<GroceryItem?>? items;

  String _name = '';
  String _address = '';
  String _title = '';

  @override
  void dispose() {
    _titleTextController?.dispose();
    _nameTextController?.dispose();
    _addressTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 12.0,
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
                        padding: EdgeInsets.zero,
                        iconSize: 24.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        onSelected: (value) async {
                          if (value == 0) {
                            await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Enter Details"),
                                    actionsPadding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 16.0,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
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
                                            textCapitalization:
                                                TextCapitalization.words,
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
                                            textCapitalization:
                                                TextCapitalization.words,
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
                                            keyboardType:
                                                TextInputType.multiline,
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
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(ctx, true);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return PdfPreviewPage(
                                                  data: items,
                                                  name: _name,
                                                  address: _address,
                                                  title: _title,
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
                          if (value == 1) {
                            if (await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text("Delete List?"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const [
                                              Text(
                                                  "Tap YES to delete the list."),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx, false);
                                            },
                                            child: const Text('NO'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(ctx, true);
                                            },
                                            child: const Text('YES'),
                                          ),
                                        ],
                                      );
                                    }) ??
                                false) {
                              await groceryProvider
                                  .deleteGroceryListItem(_groceryListId);
                              Navigator.pop(context);
                            }
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
                          fontWeight: FontWeight.w600,
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/empty_cart.svg",
                              width: deviceSize.width * 0.75,
                              height: deviceSize.height * 0.5,
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
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        var item = items[i]!;
                        return GroceryItemCard(
                          title: item.title.v ?? '',
                          description: item.description.v ?? '',
                          quantity: item.quantity.v ?? '',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 16.0),
                                    ListTile(
                                      leading: Text(
                                        "Edit",
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      trailing: const Icon(Icons.edit),
                                      onTap: () {
                                        Navigator.pop(ctx);
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
                                    ),
                                    ListTile(
                                      leading: Text(
                                        "Delete",
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      trailing:
                                          const Icon(Icons.delete_forever),
                                      onTap: () async {
                                        Navigator.pop(ctx);
                                        if (await showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (ctx) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Delete Item?"),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const [
                                                          Text(
                                                              "Tap YES to delete the item."),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              ctx, false);
                                                        },
                                                        child: const Text('NO'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              ctx, true);
                                                        },
                                                        child:
                                                            const Text('YES'),
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
                                    const SizedBox(height: 16.0),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      itemCount: items.length,
                      separatorBuilder: (BuildContext context, int index) {
                        if (index != (items.length - 1)) {
                          return const SizedBox(height: 16.0);
                        }
                        return const SizedBox(height: 0.0);
                      },
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
          icon: const Icon(
            Icons.add,
            size: 32.0,
            color: lightColor,
          ),
          padding: const EdgeInsets.all(0.0),
        ),
      ),
    );
  }
}
