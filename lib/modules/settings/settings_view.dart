import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/global_widgets/custom_list_tile.dart';
import 'package:grocery_list_maker/global_widgets/unfocus_widget.dart';
import 'package:grocery_list_maker/modules/about/about_view.dart';
import 'package:grocery_list_maker/modules/grocery_list/cubit/grocery_list_cubit.dart';
import 'package:grocery_list_maker/utils/utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart' show packageInfo;

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  void _launchUrl(BuildContext context, String url) async {
    var parsedUrl = Uri.parse(url);
    await canLaunchUrl(parsedUrl)
        ? await launchUrl(parsedUrl)
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Couldn't launch url please try again later.",
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                const SizedBox(height: 8.0),
                _buildBody(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildBody(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                CustomListTile(
                  leading: Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  title: Text(
                    "Clear All Data",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  subtitle: Text(
                    "Clear all lists and items from the database.",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.75),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onTap: () => _showDeleteDialog(context),
                ),
                const SizedBox(height: 8.0),
                CustomListTile(
                  leading: Icon(
                    Icons.feedback_outlined,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  title: Text(
                    "Contact Us",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onTap: () =>
                      _launchUrl(context, "mailto:nixlab.in@gmail.com"),
                ),
                const SizedBox(height: 8.0),
                CustomListTile(
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  title: Text(
                    "Privacy Policy",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onTap: () =>
                      _launchUrl(context, "https://nixlab.co.in/privacy"),
                ),
                const SizedBox(height: 8.0),
                CustomListTile(
                  leading: Icon(
                    Icons.share,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  title: Text(
                    "Share",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onTap: () => Share.share(
                    "Download Grocery List Maker App for generating PDF of your grocery list and items easily.",
                    subject: "Download Grocery List Maker App.\n ",
                  ),
                ),
                const SizedBox(height: 8.0),
                CustomListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  title: Text(
                    "About",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return const AboutView();
                    }),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    packageInfo.version,
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    "(${packageInfo.buildNumber})",
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            'Settings',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDeleteDialog(BuildContext context) {
    AppUtility.showAlertDialog(
      context: context,
      body: Text(
        "Tap YES to clear all lists and items.",
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
            _deleteAllLists(context);
          },
          child: const Text('YES'),
        ),
      ],
    );
  }

  void _deleteAllLists(BuildContext context) async {
    await BlocProvider.of<GroceryListCubit>(context).deleteAllGroceryLists();
    Navigator.of(context).pop();
  }
}
