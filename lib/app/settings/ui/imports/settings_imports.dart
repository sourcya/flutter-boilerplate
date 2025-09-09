import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/app/profile_update/data/repository/profile_repository.dart';
import 'package:flutter_boilerplate/app/settings/data/datasource/settings_datasource.dart';
import 'package:flutter_boilerplate/app/settings/data/model/settings_model.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart'
    show Routes;
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart'
    show MyPreferenceManger;
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playx/playx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../../data/model/quick_actions.dart';
part '../../data/model/settings_preference.dart';
part '../../data/repository/settings_repository.dart';
part '../binding/settings_binding.dart';
part '../controller/settings_controller.dart';
// Settings module parts
part '../view/settings_view.dart';
part '../view/widgets/build_settings_language_widget.dart';
part '../view/widgets/build_settings_logout_widget.dart';
part '../view/widgets/build_settings_privacy_widget.dart';
part '../view/widgets/build_settings_terms_widget.dart';
part '../view/widgets/build_settings_theme_widget.dart';
part '../view/widgets/common/animated_settings_card.dart';
part '../view/widgets/common/responsive_layout_builder.dart';
part '../view/widgets/common/settings_dialog.dart';
part '../view/widgets/common/settings_page.dart';
part '../view/widgets/common/settings_section_header.dart';
part '../view/widgets/common/settings_tile.dart';
part '../view/widgets/profile/build_user_profile_header.dart';
part '../view/widgets/profile/profile_stat_card.dart';
part '../view/widgets/tiles/animated_toggle.dart';
part '../view/widgets/tiles/interactive_settings_tile.dart';
