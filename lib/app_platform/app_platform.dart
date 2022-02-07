import 'package:grocery_list_maker/app_platform/platform/context.dart'
    show PlatformContext;

import 'src/platform.dart' as src;

export 'package:grocery_list_maker/app_platform/platform/context.dart'
    show PlatformContext;

/// To call on start to support Linux/Windows, ignored on Web and Mobile.
void platformInit() => src.platformInit();

/// Browser or io context.
PlatformContext get platformContext => src.platformContext;
