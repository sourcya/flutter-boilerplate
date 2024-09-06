import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:playx/playx.dart';
import 'package:playx_navigation/playx_navigation.dart';

import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/preferences/preference_manger.dart';
import '../../../../../core/resources/assets/assets.dart';
import '../../../../../core/resources/translation/app_locale_config.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/widgets/components/custom_text.dart';

part '../bindings/splash_binding.dart';
part '../controllers/splash_controller.dart';
part '../views/splash_view.dart';
part '../views/widgets/build_splash_app_title_widget.dart';
part '../views/widgets/build_splash_app_version_widget.dart';
part '../views/widgets/build_splash_logo_widget.dart';
