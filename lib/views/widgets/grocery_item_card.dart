import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/views/widgets/popup_menu_tile.dart';

class GroceryItemCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? quantity;
  final Color? color;
  final VoidCallback? onEditBtn;
  final VoidCallback? onDeleteBtn;

  const GroceryItemCard({
    Key? key,
    required this.title,
    this.description,
    this.quantity,
    this.onEditBtn,
    this.onDeleteBtn,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
      decoration: BoxDecoration(
        color: color ?? Colors.redAccent.withOpacity(0.25),
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
                if (quantity != null) const SizedBox(height: 4.0),
                if (quantity != null)
                  Text(
                    quantity!,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.0,
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
    );
  }
}
