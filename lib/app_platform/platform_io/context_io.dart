import '../platform/context.dart';

export './src/export.dart' show platformContextIo;

abstract class PlatformContextIo extends PlatformContext {
  /// Get user home path (HOME or USERPROFILE)
  String get userHomePath;

  /// Get user app data path (APPDATA on windows ~/.config on Mac/Linux)
  String get userAppDataPath;
}
