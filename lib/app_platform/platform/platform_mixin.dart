import 'package:grocery_list_maker/app_platform/platform/context.dart';

mixin PlatformMixin implements Platform {
  Map<String, dynamic> getPlatformInfoMap([Map<String, dynamic>? map]) {
    map ??= <String, dynamic>{};
    return map;
  }
}
