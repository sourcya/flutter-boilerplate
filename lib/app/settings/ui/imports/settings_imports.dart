import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/theme/theme.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../../core/resources/colors/app_colors.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/widgets/components/custom_card.dart';
import '../../../../core/widgets/components/custom_dialog.dart';
import '../../../../core/widgets/components/custom_scaffold.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/keyboard_visibility_padding.dart';
import '../../../app_launch/home/ui/imports/home_imports.dart';

part  '../binding/settings_binding.dart';
part  '../controller/settings_controller.dart';
part '../view/settings_view.dart';
part '../view/widgets/build_settings_language_widget.dart';
part '../view/widgets/build_settings_logout_widget.dart';
part '../view/widgets/build_settings_theme_widget.dart';
part '../view/widgets/common/settings_dialog.dart';
part '../view/widgets/common/settings_tile.dart';
