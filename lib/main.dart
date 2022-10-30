import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_list_maker/constants/app_themes.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/constants/strings.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/grocery_list.dart';
import 'package:grocery_list_maker/modules/grocery_item/cubit/grocery_item_cubit.dart';
import 'package:grocery_list_maker/modules/grocery_list/cubit/grocery_list_cubit.dart';
import 'package:grocery_list_maker/modules/grocery_list/views/grocery_list_view.dart';
import 'package:grocery_list_maker/repository/grocery_repository.dart';
import 'package:grocery_list_maker/utils/utility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

late PackageInfo packageInfo;

void main() async {
  try {
    await initPreAppServices();

    runApp(MyApp(groceryRepository: GroceryRepository()));
  } catch (err) {
    AppUtility.log('Error occurred in main: ${err.toString()}', tag: 'error');
  }
}

Future<void> initPreAppServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();

  packageInfo = await PackageInfo.fromPlatform();

  AppUtility.log('Registering Hive Adapters');

  Hive.registerAdapter(GroceryListAdapter());
  Hive.registerAdapter(GroceryItemAdapter());

  AppUtility.log('Opening Hive Boxes');

  await Hive.openBox<GroceryList>(groceryLists);
  await Hive.openBox<GroceryItem>(groceryItems);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required GroceryRepository groceryRepository})
      : _groceryRepository = groceryRepository;

  final GroceryRepository _groceryRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: GroceryRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GroceryListCubit(_groceryRepository),
          ),
          BlocProvider(
            create: (_) => GroceryItemCubit(_groceryRepository),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance.window.platformBrightness ==
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
      home: const GroceryListView(),
    );
  }
}
