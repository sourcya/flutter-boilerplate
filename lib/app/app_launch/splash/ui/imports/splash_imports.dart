import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playx/playx.dart';
import 'package:playx_version_update/playx_version_update.dart';

import '../../../../../core/config/keys.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/preferences/preference_manger.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/utils/alert.dart';
import '../../../auth/data/repo/biometric_auth_repository.dart';

part  '../bindings/splash_binding.dart';
part  '../controllers/splash_controller.dart';
part '../views/splash_view.dart';
part '../views/widgets/build_splash_app_title_widget.dart';
part '../views/widgets/build_splash_app_version_widget.dart';
