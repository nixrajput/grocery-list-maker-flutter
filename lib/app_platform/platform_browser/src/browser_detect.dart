// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'browser_detect_common.dart';

export 'browser_detect_common.dart';

class BrowserDetect extends BrowserDetectCommon {
  bool get supportsTouch => window.navigator.maxTouchPoints != null
      ? window.navigator.maxTouchPoints! > 0
      : TouchEvent.supported;

  @override
  void init() {
    userAgent ??= window.navigator.userAgent;
  }
}

BrowserDetect? _browserDetect;

BrowserDetect get browserDetect => _browserDetect ??= BrowserDetect();

bool get isIe => browserDetect.isIe;

bool get isEdge => browserDetect.isEdge;

bool get isChrome => browserDetect.isChrome;

bool get isFirefox => browserDetect.isFirefox;

bool get isSafari => browserDetect.isSafari;

bool get isChromeDartium => browserDetect.isChromeDartium;
