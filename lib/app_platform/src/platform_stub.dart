import 'package:grocery_list_maker/app_platform/platform/context.dart';

/// Support basic init for Io (Linux, Windows), skipped for Web and Mobile.
void platformInit() => _stub('platformInit');

/// Browser or io context.
PlatformContext get platformContext => _stub('platformContext');

/// Always throw.
T _stub<T>(String message) {
  throw UnimplementedError(message);
}
