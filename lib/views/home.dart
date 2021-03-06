import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/constants/strings.dart';
import 'package:grocery_list_maker/main.dart' show groceryProvider;
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/views/add_edit_list.dart';
import 'package:grocery_list_maker/views/list_details.dart';
import 'package:grocery_list_maker/views/settings.dart';
import 'package:grocery_list_maker/views/widgets/grocery_list_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    appName,
                    style: GoogleFonts.rowdies(
                      textStyle: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const SettingsPage();
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 28.0,
                    ),
                    padding: const EdgeInsets.all(0.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: StreamBuilder<List<GroceryList?>>(
                  stream: groceryProvider.onGroceryListItems(),
                  builder: (ctx, snapshot) {
                    var items = snapshot.data;
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
                              width: _deviceSize.width * 0.75,
                              height: _deviceSize.height * 0.5,
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "No lists.",
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
                        return GroceryListCard(
                          title: item.title.v ?? '',
                          addedAt: item.addedAt.v ?? '',
                          onViewBtn: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return ListDetailsPage(
                                    initialItem: item,
                                  );
                                },
                              ),
                            );
                          },
                          onEditBtn: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return AddEditListPage(
                                    initialItem: item,
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
                                  .deleteGroceryListItem(item.id.v);
                            }
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
              return const AddEditListPage(
                initialItem: null,
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
