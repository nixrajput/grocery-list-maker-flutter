import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart' show packageInfo;

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void _launchUrl(BuildContext context, String url) async {
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
                        "About",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/logo.png",
                            width: deviceSize.width * 0.4,
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$appName ",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "is a multi-platform application made in ",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "India 🇮🇳",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: " and developed by ",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "Nikhil Rajput",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: " and powered by ",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "NixLab Technologies",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ". This application is made to reduce your effort while making a grocery list or any items list with the help of pen and paper that is very time consuming and sometimes irritating.",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "\nBy Using this application you can easily create any items list in minutes and generate PDF.",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "\n\nThank you for choosing our application. We are committed to add and introduce many new and exciting features in the application in coming days.",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "\n\nFor any feedback or suggestion, feel free to write us",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchUrl(
                                        context, 'mailto:nixlab.in@gmail.com');
                                  },
                                text: " here",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.clip,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "VERSION",
                              style: GoogleFonts.montserrat(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(width: 8.0),
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
                        const SizedBox(height: 8.0),
                        Center(
                          child: Text(
                            "© Copyright 2021-2022 NixLab.",
                            style: GoogleFonts.montserrat(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
