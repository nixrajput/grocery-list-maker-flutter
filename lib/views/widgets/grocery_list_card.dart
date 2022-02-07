import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/views/widgets/popup_menu_tile.dart';
import 'package:intl/intl.dart';

class GroceryListCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? quantity;
  final String? addedAt;
  final Color? color;
  final VoidCallback? onViewBtn;
  final VoidCallback? onEditBtn;
  final VoidCallback? onDeleteBtn;

  const GroceryListCard({
    Key? key,
    required this.title,
    this.description,
    this.quantity,
    this.addedAt,
    this.color,
    this.onViewBtn,
    this.onEditBtn,
    this.onDeleteBtn,
  }) : super(key: key);

  String _formatDate(DateTime date) {
    final format = DateFormat.yMMMd('en_US');
    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewBtn,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
        decoration: BoxDecoration(
          color: color ?? Colors.redAccent,
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  if (description != null && description != '')
                    Text(
                      description!,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0,
                        ),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  if (addedAt != null) const SizedBox(height: 4.0),
                  if (addedAt != null)
                    Text(
                      _formatDate(DateTime.parse(addedAt!)),
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12.0,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: (value) async {
                if (value == 0) onEditBtn!();
                if (value == 1) onDeleteBtn!();
              },
              itemBuilder: (ctx) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: PopUpMenuTile(
                      title: 'Edit',
                      icon: Icons.edit,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: PopUpMenuTile(
                      title: 'Delete',
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
      ),
    );
  }
}
