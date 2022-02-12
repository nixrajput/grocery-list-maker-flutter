import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/views/widgets/popup_menu_tile.dart';
import 'package:intl/intl.dart';

class GroceryListCard extends StatelessWidget {
  final String title;
  final String? quantity;
  final String? addedAt;
  final VoidCallback? onViewBtn;
  final VoidCallback? onEditBtn;
  final VoidCallback? onDeleteBtn;

  const GroceryListCard({
    Key? key,
    required this.title,
    this.quantity,
    this.addedAt,
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
    return InkWell(
      onTap: onViewBtn,
      child: Container(
        padding: const EdgeInsets.only(
          top: 4.0,
          left: 4.0,
          bottom: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: Row(
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
                      height: 28.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        if (addedAt != null) const SizedBox(height: 4.0),
                        if (addedAt != null)
                          Text(
                            "Added on ${_formatDate(DateTime.parse(addedAt!))}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                overflow: TextOverflow.clip,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 1,
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                iconSize: 24.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
