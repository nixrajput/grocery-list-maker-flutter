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
    return Container(
      width: double.infinity,
      height: 92.0,
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade600.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Image.asset(
              "assets/ingredients.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.quantity ?? '',
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 1,
                ),
                if (item.description != null && item.description!.isNotEmpty)
                  Text(
                    item.description!,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          if (onDelete != null)
            GestureDetector(
              onTap: () => _showOptionsBottomSheet(context),
              child: const Icon(
                Icons.chevron_right,
                size: 32.0,
              ),
            ),
        ],
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
      body: Text(
        "Tap YES to delete the item.",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
      ),
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
