import 'dart:io';

import 'package:grocery_list_maker/app_platform/platform/context.dart'
    show PlatformContext;
import 'package:grocery_list_maker/app_platform/platform_io/src/context_io.dart';

void platformInit() {
  // No need to handle macOS, as it has now been added to TargetPlatform.
  if (Platform.isLinux || Platform.isWindows) {
    // As of 2020/07/01 this seems no longer needed
    // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

PlatformContext get platformContext => platformContextIo;
