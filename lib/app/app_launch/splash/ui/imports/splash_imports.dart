import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/core/navigation/app_navigation.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/resources/assets/assets.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_locale_config.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_text.dart';
import 'package:playx/playx.dart';

part '../bindings/splash_binding.dart';
part '../controllers/splash_controller.dart';
part '../views/splash_view.dart';
part '../views/widgets/build_splash_app_title_widget.dart';
part '../views/widgets/build_splash_app_version_widget.dart';
part '../views/widgets/build_splash_logo_widget.dart';
