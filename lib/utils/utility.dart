import 'dart:math';

import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

extension DateTimeFormat on DateTime {
  String formatDate({String? format}) {
    final formatter =
        format != null ? DateFormat(format) : DateFormat.yMMMd('en_US');
    return formatter.format(this);
  }
}

abstract class AppUtility {
  /// Logger

  static final _logger = Talker();

  static void log(dynamic message, {String? tag}) {
    switch (tag) {
      case 'error':
        _logger.error(message);
        break;
      case 'warning':
        _logger.warning(message);
        break;
      case 'info':
        _logger.info(message);
        break;
      case 'debug':
        _logger.debug(message);
        break;
      case 'critical':
        _logger.critical(message);
        break;
      default:
        _logger.verbose(message);
        break;
    }
  }

  /// Close any open snack bar.

  // static void closeSnackBar() {
  //   if (Get.isSnackbarOpen) Get.back<void>();
  // }
  //
  // /// Close any open dialog.
  //
  // static void closeDialog() {
  //   if (Get.isDialogOpen ?? false) Get.back<void>();
  // }
  //
  // /// Close any open bottom sheet.
  //
  // static void closeBottomSheet() {
  //   if (Get.isBottomSheetOpen ?? false) Get.back<void>();
  // }
  //
  // static void closeFocus() {
  //   if (FocusManager.instance.primaryFocus!.hasFocus) {
  //     FocusManager.instance.primaryFocus?.unfocus();
  //   }
  // }
  //
  // /// Show Loading Dialog
  //
  // static void showLoadingDialog({
  //   double? value,
  //   bool? barrierDismissible,
  //   String? message,
  // }) {
  //   closeSnackBar();
  //   closeDialog();
  //   Get.dialog(
  //     WillPopScope(
  //       onWillPop: () async => false,
  //       child: Scaffold(
  //         backgroundColor: Colors.transparent,
  //         body: Center(
  //           child: Container(
  //             padding: Dimens.edgeInsets16,
  //             decoration: BoxDecoration(
  //               color: Theme.of(Get.context!).dialogTheme.backgroundColor,
  //               borderRadius: BorderRadius.circular(Dimens.eight),
  //             ),
  //             constraints: BoxConstraints(
  //               maxWidth: Dimens.screenWidth,
  //               maxHeight: Dimens.screenHeight,
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 NxCircularProgressIndicator(
  //                   color: Theme.of(Get.context!).textTheme.bodyText1!.color,
  //                   size: Dimens.fourtyEight,
  //                   value: value,
  //                 ),
  //                 Dimens.boxHeight12,
  //                 Text(
  //                   message ?? 'Please wait...',
  //                   style: AppStyles.style16Normal.copyWith(
  //                     color: Theme.of(Get.context!).textTheme.bodyText1!.color,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     barrierDismissible: barrierDismissible ?? false,
  //     name: 'loading_dialog',
  //     navigatorKey: GlobalKey<NavigatorState>(),
  //   );
  // }
  //
  // /// Text Logo
  //
  // static buildAppLogo({double? fontSize, bool? isCentered = false}) => Text(
  //   StringValues.appName.toUpperCase(),
  //   style: AppStyles.style24Bold.copyWith(
  //     fontFamily: "Muge",
  //     fontSize: fontSize,
  //     letterSpacing: Dimens.four,
  //   ),
  //   textAlign: isCentered == true ? TextAlign.center : TextAlign.start,
  // );
  //
  // /// Show Simple Dialog
  //
  // static void showSimpleDialog(Widget child,
  //     {bool barrierDismissible = false}) {
  //   closeSnackBar();
  //   closeDialog();
  //   Get.dialog(
  //     MediaQuery.removeViewInsets(
  //       context: Get.context!,
  //       removeLeft: true,
  //       removeTop: true,
  //       removeRight: true,
  //       removeBottom: true,
  //       child: ConstrainedBox(
  //         constraints: BoxConstraints(
  //           maxHeight: Dimens.screenHeight,
  //           maxWidth: Dimens.hundred * 6,
  //         ),
  //         child: Padding(
  //           padding: Dimens.edgeInsets16,
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: Material(
  //               type: MaterialType.card,
  //               color: Theme.of(Get.context!).dialogBackgroundColor,
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(Dimens.eight),
  //               ),
  //               child: child,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     barrierDismissible: barrierDismissible,
  //     barrierColor: ColorValues.blackColor.withOpacity(0.75),
  //     name: 'simple_dialog',
  //   );
  // }
  //
  // static void showError(String message) {
  //   closeSnackBar();
  //   closeBottomSheet();
  //   if (message.isEmpty) return;
  //   Get.rawSnackbar(
  //     messageText: Text(
  //       message,
  //     ),
  //     mainButton: TextButton(
  //       onPressed: () {
  //         if (Get.isSnackbarOpen) {
  //           Get.back<void>();
  //         }
  //       },
  //       child: const Text(
  //         StringValues.okay,
  //       ),
  //     ),
  //     backgroundColor: const Color(0xFF503E9D),
  //     margin: Dimens.edgeInsets16,
  //     borderRadius: Dimens.fifteen,
  //     snackStyle: SnackStyle.FLOATING,
  //   );
  // }
  //
  // /// Show No Internet Dialog
  //
  // static void showNoInternetDialog() {
  //   closeDialog();
  //   Get.dialog<void>(
  //     WillPopScope(
  //       onWillPop: () async => false,
  //       child: Scaffold(
  //         body: Padding(
  //           padding: Dimens.edgeInsets16,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               NxAssetImage(
  //                 imgAsset: AssetValues.error,
  //                 width: Dimens.hundred * 1.6,
  //                 height: Dimens.hundred * 1.6,
  //               ),
  //               Dimens.boxHeight16,
  //               Text(
  //                 'No Internet!',
  //                 textAlign: TextAlign.center,
  //                 style: AppStyles.style24Bold.copyWith(
  //                   color: ColorValues.errorColor,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     barrierDismissible: false,
  //     name: 'no_internet_dialog',
  //   );
  // }
  //
  // /// Show BottomSheet
  //
  // static void showBottomSheet(List<Widget> children, {double? borderRadius}) {
  //   closeBottomSheet();
  //   Get.bottomSheet(
  //     Padding(
  //       padding: Dimens.edgeInsets8_0,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         mainAxisSize: MainAxisSize.min,
  //         children: children,
  //       ),
  //     ),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(borderRadius ?? Dimens.zero),
  //         topRight: Radius.circular(borderRadius ?? Dimens.zero),
  //       ),
  //     ),
  //     barrierColor: ColorValues.blackColor.withOpacity(0.75),
  //     backgroundColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor,
  //   );
  // }
  //
  // /// Show Overlay
  // static void showOverlay(Function func) {
  //   Get.showOverlay(
  //     loadingWidget: const CupertinoActivityIndicator(),
  //     opacityColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor!,
  //     opacity: 0.5,
  //     asyncFunction: () async {
  //       await func();
  //     },
  //   );
  // }
  //
  // /// Show SnackBar
  //
  // static void showSnackBar(String message, String type, {int? duration}) {
  //   closeSnackBar();
  //   Get.showSnackbar(
  //     GetSnackBar(
  //       margin: EdgeInsets.only(
  //         left: Dimens.sixTeen,
  //         right: Dimens.sixTeen,
  //         top: Dimens.eight,
  //       ),
  //       borderRadius: Dimens.eight,
  //       padding: Dimens.edgeInsets16,
  //       snackStyle: SnackStyle.FLOATING,
  //       snackPosition: SnackPosition.TOP,
  //       borderWidth: Dimens.zero,
  //       messageText: Text(
  //         message.toCapitalized(),
  //         style: AppStyles.style14Normal.copyWith(
  //           color: renderTextColor(type),
  //         ),
  //       ),
  //       icon: Icon(
  //         renderIcon(type),
  //         color: renderIconColor(type),
  //         size: Dimens.twenty,
  //       ),
  //       mainButton: Padding(
  //         padding: Dimens.edgeInsets0_8,
  //         child: NxTextButton(
  //           label: 'DISMISS',
  //           labelStyle: AppStyles.style13Bold.copyWith(
  //             color: Theme.of(Get.context!).textTheme.bodyText1!.color!,
  //           ),
  //           onTap: closeSnackBar,
  //         ),
  //       ),
  //       shouldIconPulse: false,
  //       backgroundColor: Theme.of(Get.context!)
  //           .snackBarTheme
  //           .backgroundColor!
  //           .withOpacity(0.25),
  //       barBlur: Dimens.twentyFour,
  //       dismissDirection: DismissDirection.horizontal,
  //       duration: Duration(seconds: duration ?? 3),
  //     ),
  //   );
  // }

  /// --------------------------------------------------------------------------

  /// Random String
  static String generateUid(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890@!%&_';
    var rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        16,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }
}
