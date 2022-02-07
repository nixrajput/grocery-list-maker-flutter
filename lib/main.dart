import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:grocery_list_maker/constants/app_themes.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/constants/strings.dart';
import 'package:grocery_list_maker/providers/grocery_provider.dart';
import 'package:grocery_list_maker/views/home.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';

import 'app_platform/app_platform.dart';

late GroceryProvider groceryProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  platformInit();

  if (!kIsWeb) {
    sqfliteWindowsFfiInit();
  }

  var packageName = 'com.nixlab.grocery_list_maker';
  var databaseFactory = getDatabaseFactory(packageName: packageName);

  groceryProvider = GroceryProvider(databaseFactory);
  await groceryProvider.ready;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: lightBGColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: lightBGColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: darkBGColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: darkBGColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
