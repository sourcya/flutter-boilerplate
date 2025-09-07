import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_boilerplate/app/app_launch/app/ui/imports/app_imports.dart' show AppController;
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/app/legal_document/ui/imports/legal_imports.dart'
    show PrivacyPolicyView, TermsConditionsView;
import 'package:flutter_boilerplate/app/settings/data/datasource/settings_datasource.dart';
import 'package:flutter_boilerplate/app/settings/data/model/settings_model.dart';
import 'package:flutter_boilerplate/app/settings/data/repository/settings_repository.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart'
    show Routes;
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart'
    show MyPreferenceManger;
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:playx/playx.dart';

part '../binding/settings_binding.dart';
part '../controller/settings_controller.dart';
part '../view/settings_view.dart';
part '../view/widgets/build_settings_language_widget.dart';
part '../view/widgets/build_settings_logout_widget.dart';
part '../view/widgets/build_settings_privacy_widget.dart';
part '../view/widgets/build_settings_terms_widget.dart';
part '../view/widgets/build_settings_theme_widget.dart';
part '../view/widgets/build_user_profile_header.dart';
part '../view/widgets/common/settings_dialog.dart';
part '../view/widgets/common/settings_page.dart';
part '../view/widgets/common/settings_tile.dart';
