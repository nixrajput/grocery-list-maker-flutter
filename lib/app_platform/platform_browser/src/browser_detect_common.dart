import 'package:pub_semver/pub_semver.dart';

// Current way to detect javascript
bool get isRunningAsJavascript => identical(1.0, 1);

/// Regex that matches a version number at the beginning of a string.
final _startVersion = RegExp(r'^' // Start at beginning.
    r'(\d+).((\d+))?' // Version number.
    );

/// Like [_startVersion] but matches the entire string.
final _completeVersion = RegExp('${_startVersion.pattern}\$');

// Handle String with 4 numbers
/// Regex that matches a version number at the beginning of a string.
final _fourNumbersStartVersion = RegExp(r'^' // Start at beginning.
        r'(\d+).(\d+).(\d+).([0-9A-Za-z-]*)') // Version number.
    ;

/// Like [_startVersion] but matches the entire string.
final _fourNumbersCompleteVersion =
    RegExp('${_fourNumbersStartVersion.pattern}\$');

/// Add support for version X, X.X not supported in platform version
Version parseVersion(String text) {
  try {
    return Version.parse(text);
  } on FormatException catch (e, _) {
    Match? match = _completeVersion.firstMatch(text);
    if (match != null) {
      try {
        //      print(match[0]);
        //      print(match[1]);
        //      print(match[2]);
        final major = int.parse(match[1]!);
        final minor = int.parse(match[2]!);

        return Version(major, minor, 0);
      } on FormatException catch (_) {
        throw e;
      }
    } else {
      match = _fourNumbersCompleteVersion.firstMatch(text);
      if (match != null) {
        try {
          //      print(match[0]);
          //      print(match[1]);
          //      print(match[2]);
          final major = int.parse(match[1]!);
          final minor = int.parse(match[2]!);
          final patch = int.parse(match[3]!);
          final build = match[4];

          return Version(major, minor, patch, build: build);
        } on FormatException catch (_) {
          throw e;
        }
      } else {
        throw FormatException('Could not parse "$text".');
      }
    }
  }
}

class BrowserDetectCommon {
  // Handle stuff like 'Trident/7.0, Chrome/29.0...'
  bool _checkAndGetVersion(String name) {
    final index = _userAgent!.indexOf(name);
    if (index >= 0) {
      var versionString = _userAgent!.substring(index + name.length + 1);
      var endVersion = versionString.indexOf(' ');
      if (endVersion >= 0) {
        versionString = versionString.substring(0, endVersion);
      }
      endVersion = versionString.indexOf(';');
      if (endVersion >= 0) {
        versionString = versionString.substring(0, endVersion);
      }
      _browserVersion = parseVersion(versionString);
      return true;
    }
    return false;
  }

  Version? _browserVersion;
  bool? _isFirefox;
  bool? _isSafari;
  bool? _isMobile;
  bool? _isChrome;
  bool? _isIe;
  bool? _isEdge;

  // OS
  bool? _isWindows;
  bool? _isMac;
  bool? _isLinux;

  // Version 0 if not found
  Version get browserVersion => _browserVersion ??= () {
        // Check all platforms
        isIe;
        isEdge;
        isChrome;
        isChromeChromium;
        isSafari;
        isFirefox;
        return _browserVersion;
      }() ??
      Version.none;

  bool get isIe {
    if (_isIe == null) {
      init();
      // Edge 12 and over
      _isIe = _checkAndGetVersion('Trident');
    }
    return _isIe!;
  }

  bool get isEdge {
    if (_isEdge == null) {
      init();
      // Edge 12 and over
      _isEdge = _checkAndGetVersion('Edge');
    }
    return _isEdge!;
  }

  // to deprecate
  bool get isIos => isMobileIOS;

  bool get isChrome {
    if (_isChrome == null) {
      init();
      // Can check vendor too...
      _isChrome = _checkAndGetVersion('Chrome');
    }
    return _isChrome!;
  }

  bool get isChromeChromium {
    return isChrome && _checkAndGetVersion('Chromium');
  }

  bool get isChromeDartium {
    return isChrome && _userAgent!.contains('(Dart)');
  }

  bool get isFirefox {
    if (_isFirefox == null) {
      init();
      _isFirefox = _checkAndGetVersion('Firefox');
    }
    return _isFirefox!;
  }

  bool get isSafari {
    if (_isSafari == null) {
      init();
      _isSafari = !isChrome && _userAgent!.contains('Safari');
      if (_isSafari!) {
        _checkAndGetVersion('Version');
      }
    }
    return _isSafari!;
  }

  // on chrome
  // on ie:  For Windows environments, value Windows NT 6.3 stands for Win 8.1, Windows NT 6.2 for Win 8, Windows NT 6.1 for Win 7 and so on
  bool get isWindows => _isWindows ??= _userAgent!.contains('Windows');

  bool get isMac => _isMac ??= _userAgent!.contains('Macintosh');

  bool get isLinux => _isLinux ??= _userAgent!.contains('Linux');

  // every browser can be mobile
  bool get isMobile => _isMobile ??= () {
        return _userAgent!.contains('Mobile/') ||
            _userAgent!.contains('Mobile ') ||
            _userAgent!.contains(' Mobile');
      }();

  bool get isMobileIOS {
    return isMobile && (_canBeIPad || _canBeIPod || _canBeIPhone);
  }

  bool get _canBeIPhone {
    return _userAgent!.contains('iPhone');
  }

  bool get isMobileIPhone {
    return isMobile && _canBeIPhone;
  }

  bool get isMobileIPad {
    return isMobile && _canBeIPad;
  }

  bool get _canBeIPad {
    return _userAgent!.contains('iPad');
  }

  bool get isMobileIPod {
    return isMobile && _canBeIPod;
  }

  bool get _canBeIPod {
    return _userAgent!.contains('iPod');
  }

  bool get isMobileAndroid {
    return isMobile && _userAgent!.contains('Android');
  }

  String? _userAgent;

  String? get userAgent => _userAgent;

  set userAgent(String? userAgent) {
    _userAgent = userAgent;

    // Navigator
    _isFirefox = null;
    _isChrome = null;
    _isSafari = null;
    _isIe = null;
    _isEdge = null;

    _isMobile = null;
    _browserVersion = null;

    if (_userAgent != null) {
      // ie/edge is tricky as it sets others
      if (isIe || isEdge) {
        _isFirefox = false;
        _isChrome = false;
        _isSafari = false;
      }
    }
  }

  void init() {}
}
