import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/playx_binding.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_text.dart';
import 'package:go_router/src/state.dart';
import 'package:playx/playx.dart';
import 'package:playx_version_update/playx_version_update.dart';

import '../../../../../core/config/constant.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/preferences/preference_manger.dart';
import '../../../../../core/resources/translation/app_translations.dart';

part '../bindings/splash_binding.dart';
part '../controllers/splash_controller.dart';
part '../views/splash_view.dart';
part '../views/widgets/build_splash_app_title_widget.dart';
part '../views/widgets/build_splash_app_version_widget.dart';
