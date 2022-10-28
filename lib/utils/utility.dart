import 'dart:math';

import 'package:flutter/material.dart';
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

  static void showAlertDialog({
    required BuildContext context,
    required Widget body,
    List<Widget>? actions,
    Widget? title,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          alignment: Alignment.center,
          insetPadding: const EdgeInsets.all(16.0),
          actionsPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          title: title,
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: body,
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

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
