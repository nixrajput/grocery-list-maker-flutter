import '../platform/context.dart';
import 'src/context_browser.dart' as context_browser;

PlatformContext get platformContextBrowser =>
    context_browser.browserPlatformContext;
