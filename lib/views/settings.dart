import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/views/about.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart' show packageInfo, groceryProvider;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _launchUrl(String url) async {
    await canLaunch(url)
        ? await launch(url)
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

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      margin: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Settings",
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              if (await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: const Text("Clear All Data?"),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const [
                                                Text(
                                                    "Tap YES to clear all lists and items."),
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
                                await groceryProvider.deleteDb();
                                Navigator.pop(context);
                              }
                            },
                            contentPadding: const EdgeInsets.all(0.0),
                            leading: Icon(
                              Icons.cancel_outlined,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.5),
                            ),
                            title: Text(
                              "Clear All Data",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
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
                          ),
                          const Divider(),
                          ListTile(
                            onTap: () {
                              _launchUrl("mailto:nixlab.in@gmail.com");
                            },
                            contentPadding: const EdgeInsets.all(0.0),
                            leading: Icon(
                              Icons.feedback_outlined,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.5),
                            ),
                            title: Text(
                              "Contact Us",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            onTap: () {
                              _launchUrl("https://nixlab.co.in/privacy");
                            },
                            contentPadding: const EdgeInsets.all(0.0),
                            leading: Icon(
                              Icons.privacy_tip_outlined,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.5),
                            ),
                            title: Text(
                              "Privacy Policy",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            onTap: () {
                              Share.share(
                                "Download Grocery List Maker App for generating PDF of your grocery list and items easily.",
                                subject: "Download Grocery List Maker App.\n ",
                              );
                            },
                            contentPadding: const EdgeInsets.all(0.0),
                            leading: Icon(
                              Icons.share,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.5),
                            ),
                            title: Text(
                              "Share",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return const AboutPage();
                                }),
                              );
                            },
                            contentPadding: const EdgeInsets.all(0.0),
                            leading: Icon(
                              Icons.info_outline,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.5),
                            ),
                            title: Text(
                              "About",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const Divider(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
