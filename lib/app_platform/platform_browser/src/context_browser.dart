import 'package:pub_semver/pub_semver.dart';

import '../../platform/context.dart';
import 'browser/operating_system.dart';
import 'browser_detect.dart';

class _Device implements BrowserDevice {
  BrowserDetect? _detect;

  _Device([this._detect]) {
    _detect ??= BrowserDetect();
  }

  @override
  bool get isMobile => _detect!.isMobile;

  @override
  bool get isIPad => _detect!.isMobileIPad;

  @override
  bool get isIPhone => _detect!.isMobileIPhone;

  @override
  bool get isIPod => _detect!.isMobileIPod;

  @override
  bool get supportsTouch => _detect!.supportsTouch;
}

class _Browser implements Browser {
  final _detect = BrowserDetect();

  OperatingSystemBrowser? _os;
  BrowserDevice? _device;

  String? get navigatorText {
    String? navigator;
    if (isIe) {
      navigator = 'ie';
    } else if (isFirefox) {
      navigator = 'firefox';
    } else if (isChrome) {
      if (isChromeDartium) {
        navigator = 'dartium';
      } else if (isChromeChromium) {
        navigator = 'chromium';
      } else {
        navigator = 'chrome';
      }
    } else if (isSafari) {
      navigator = 'safari';
    }
    return navigator;
  }

  @override
  Version get version => _detect.browserVersion;

  @override
  String toString() => toMap().toString();

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['navigator'] = navigatorText;
    map['version'] = version.toString();
    map['os'] = os.toMap();
    if (isDartVm) {
      map['dartVm'] = true;
    }
    return map;
  }

  @override
  bool get isIe => _detect.isIe;

  @override
  bool get isFirefox => _detect.isFirefox;

  @override
  bool get isSafari => _detect.isSafari;

  @override
  bool get isChrome => _detect.isChrome;

  @override
  bool get isChromeChromium => _detect.isChromeChromium;

  @override
  bool get isChromeDartium => _detect.isChromeDartium;

  // Ugly way to test if running as dart or javascript
  @override
  bool get isDartVm => !isRunningAsJavascript;

  @override
  bool get isMobile => _detect.isMobile;

  @override
  OperatingSystemBrowser get os => _os ??= OperatingSystemBrowser(_detect);

  @override
  BrowserDevice get device => _device ??= _Device(_detect);
}

class _BrowserPlatformContext implements PlatformContext {
  @override
  Io? get io => null;

  @override
  Node? get node => null;

  // non null if in io
  @override
  final _Browser browser = _Browser();

  _BrowserPlatformContext() {
    browser._detect.init();
  }

  @override
  String toString() => toMap().toString();

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'browser': browser.toMap()};
    return map;
  }

  @override
  Platform? get platform => null;
}

PlatformContext? _browserPlatformContext;

PlatformContext get browserPlatformContext =>
    _browserPlatformContext ??= _BrowserPlatformContext();
