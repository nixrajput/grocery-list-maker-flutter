import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceryItemCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? quantity;
  final VoidCallback? onTap;

  const GroceryItemCard({
    Key? key,
    required this.title,
    this.description,
    this.quantity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Row(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        if (description != null && description != '')
                          Text(
                            description!,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.6),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: Text(
                quantity!,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    overflow: TextOverflow.clip,
                  ),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
