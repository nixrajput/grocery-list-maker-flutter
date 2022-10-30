import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/utils/utility.dart';

class GroceryListCard extends StatelessWidget {
  final GroceryList item;
  final VoidCallback? onViewBtn;
  final VoidCallback? onEditBtn;
  final VoidCallback? onDeleteBtn;
  final Color? bgColor;

  const GroceryListCard({
    Key? key,
    required this.item,
    this.onViewBtn,
    this.onEditBtn,
    this.onDeleteBtn,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewBtn,
      onLongPress: () => _showOptionsBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Image.asset(
                "assets/wishlist.png",
                width: 40.0,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          overflow: TextOverflow.clip,
                        ),
                  ),
                  if (item.itemsCount != null)
                    Text(
                      "${item.itemsCount} items",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            overflow: TextOverflow.clip,
                          ),
                    ),
                  Text(
                    "Added on ${item.createdAt.formatDate()}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.0,
                          overflow: TextOverflow.clip,
                        ),
                  ),
                ],
              ),
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
                onEditBtn?.call();
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
        "Tap YES to delete the list.",
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
            onDeleteBtn?.call();
          },
          child: const Text('YES'),
        ),
      ],
    );
  }
}
