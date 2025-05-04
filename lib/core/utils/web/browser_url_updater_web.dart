import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

/// Updates the browser's URL without navigating.
void updateBrowserUrl(Uri uri) {
  if (!PlayxPlatform.isWeb) return;

  // Use the HTML5 History API to update the browser's URL
  html.window.history.replaceState(null, '', uri.toString());
}

/// Updates the browser's URL query parameters without navigating.
void updateBrowserUrlQueryParameters(Map<String, String> newParams) {
  if (!PlayxPlatform.isWeb) return;

  // Get the current URL
  Uri? currentUri = Uri.tryParse(html.window.location.href);

  if (currentUri == null) {
    // If the current URI is null, retrieve it from GoRouter's state
    final router = AppPages.router;
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;

    currentUri = matchList.uri;
  }

  // Create a new URI with updated query parameters
  final newUri = currentUri.replace(queryParameters: newParams);

  // Update the browser's URL without navigating
  html.window.history.replaceState(null, '', newUri.toString());
}

void updateBodyBackgroundColor(bool isDark) {
  final body = html.document.body;
  if (isDark) {
    body?.classes
      ?..remove('light-mode')
      ..add('dark-mode');
  } else {
    body?.classes
      ?..remove('dark-mode')
      ..add('light-mode');
  }
}

void setAppTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: title,
      // ignore: deprecated_member_use
      primaryColor: AppColors.primaryKey.value,
    ),
  );
}
