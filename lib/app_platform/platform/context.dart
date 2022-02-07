library tekartik_platform_context.context;

import 'package:pub_semver/pub_semver.dart';

abstract class OperatingSystem {
  bool get isWindows;

  bool get isMac;

  bool get isLinux;

  bool get isAndroid;

  bool get isIOS;
}

abstract class BrowserDevice {
  bool get isMobile;

  bool get isIPad;

  bool get isIPod;

  bool get isIPhone;

  bool get supportsTouch;
}

abstract class Browser {
  OperatingSystem get os;

  BrowserDevice get device;

  bool get isIe;

  bool get isFirefox;

  bool get isSafari;

  bool get isChrome;

  bool get isChromeDartium;

  bool get isChromeChromium;

  // browser version
  Version get version;

  // If the browser contain the dart vm
  bool get isDartVm;

  // Mobile browser version;
  bool get isMobile;
}

abstract class Io extends Platform {
  /// 2019-01-31 deprecated use [isMacOS]
  bool get isMac;

  ///
  /// true if IOS operating system
  ///
  bool get isIOS;

  ///
  /// true if Android operating system
  ///
  bool get isAndroid;
}

abstract class Node extends Platform {
  /// 2019-01-31 deprecated use [isMacOS]
  bool get isMac;
}

/// Common platform for io & node
abstract class Platform {
  ///
  /// true if windows operating system
  ///
  bool get isWindows;

  ///
  /// true if OS X operating system
  ///
  bool get isMacOS;

  ///
  /// true if Linux operating system
  ///
  bool get isLinux;

  /// Environment variables
  Map<String, String> get environment;
}

/// Common platform context
abstract class PlatformContext {
  /// non null if in a browser
  Browser? get browser;

  /// Non null for io & node
  Platform? get platform;

  /// non null if in io
  Io? get io;

  /// non null if in node
  Node? get node;

  /// for debugging
  Map<String, dynamic> toMap();
}
