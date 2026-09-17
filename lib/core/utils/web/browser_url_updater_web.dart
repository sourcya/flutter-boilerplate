import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';
import 'package:web/web.dart' as web;

/// Updates the browser's URL without navigating.
void updateBrowserUrl(Uri uri) {
  if (!PlayxPlatform.isWeb) return;

  // Use the HTML5 History API to update the browser's URL
  web.window.history.replaceState(null, '', uri.toString());
}

/// Updates the browser's URL query parameters without navigating.
void updateBrowserUrlQueryParameters(Map<String, String> newParams) {
  if (!PlayxPlatform.isWeb) return;

  // Get the current URL
  Uri? currentUri = Uri.tryParse(web.window.location.href);

  if (currentUri == null) {
    // If the current URI is null, retrieve it from GoRouter's state
    final router = AppPages.router;
    final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;

    currentUri = matchList.uri;
  }

  // Create a new URI with updated query parameters
  final newUri = currentUri.replace(queryParameters: newParams);

  // Update the browser's URL without navigating
  web.window.history.replaceState(null, '', newUri.toString());
}

void updateBodyBackgroundColor(bool isDark) {
  final classList = web.document.body?.classList;
  if (classList == null) return;
  if (isDark) {
    classList
      ..remove('light-mode')
      ..add('dark-mode');
  } else {
    classList
      ..remove('dark-mode')
      ..add('light-mode');
  }
}

void setAppTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: title,
      primaryColor: AppColors.primaryKey.toARGB32(),
    ),
  );
}
