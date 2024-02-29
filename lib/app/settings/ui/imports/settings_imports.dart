import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/app_router.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/playx_binding.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../../core/resources/colors/app_colors.dart';
import '../../../../core/resources/translation/app_locale_config.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/widgets/bottom_sheet/custom_modal.dart';
import '../../../../core/widgets/components/custom_card.dart';
import '../../../../core/widgets/components/custom_dialog.dart';
import '../../../../core/widgets/components/custom_text.dart';
import '../../../../core/widgets/keyboard_visibility_padding.dart';

part '../binding/settings_binding.dart';
part '../controller/settings_controller.dart';
part '../view/settings_view.dart';
part '../view/widgets/build_settings_language_widget.dart';
part '../view/widgets/build_settings_logout_widget.dart';
part '../view/widgets/build_settings_theme_widget.dart';
part '../view/widgets/common/settings_dialog.dart';
part '../view/widgets/common/settings_page.dart';
part '../view/widgets/common/settings_tile.dart';
