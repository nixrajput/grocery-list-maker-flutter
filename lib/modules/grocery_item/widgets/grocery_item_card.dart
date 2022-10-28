import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/modules/grocery_item/views/add_edit_item_view.dart';
import 'package:grocery_list_maker/utils/utility.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem item;
  final VoidCallback? onDelete;
  final Color? bgColor;

  const GroceryItemCard({
    Key? key,
    required this.item,
    this.onDelete,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showOptionsBottomSheet(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Image.asset(
                    "assets/ingredients.png",
                    height: 24.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      maxLines: 2,
                    ),
                    if (item.description != null &&
                        item.description!.isNotEmpty)
                      Row(
                        children: [
                          Text(
                            "Description: ",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Text(
                            item.description!,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    if (item.quantity != null && item.quantity!.isNotEmpty)
                      Row(
                        children: [
                          Text(
                            "Quantity: ",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Text(
                            item.quantity!,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Text(
                      "Added on ${item.createdAt.formatDate()}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          overflow: TextOverflow.clip,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.color
                              ?.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
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
                      return AddEditItemView(
                        initialItem: item,
                        groceryListId: item.listId,
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
              trailing: const Icon(Icons.delete_forever),
              onTap: () {
                Navigator.pop(ctx);
                _showDeleteDialog(context);
              },
            ),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  _showDeleteDialog(BuildContext context) async {
    AppUtility.showAlertDialog(
      context: context,
      body: const Text("Tap YES to delete the item."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('NO'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
            onDelete?.call();
          },
          child: const Text('YES'),
        ),
      ],
    );
  }
}
