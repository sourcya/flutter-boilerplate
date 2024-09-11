import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';
import 'package:playx_navigation/playx_navigation.dart';

import '../../../../../../core/navigation/app_navigation.dart';
import '../../../../../../core/resources/assets/assets.dart';
import '../../../../../../core/resources/colors/app_colors.dart';
import '../../../../../../core/resources/translation/app_translations.dart';
import '../../../../../../core/utils/alert.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../../core/utils/are_equals_validation.dart';
import '../../../../../../core/widgets/components/custom_text.dart';
import '../../../../../../core/widgets/components/text_field.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';

part '../bindings/register_binding.dart';
part '../controllers/register_controller.dart';
part '../views/register_view.dart';
part '../views/widgets/build_register_button_widget.dart';
part '../views/widgets/build_register_confirm_password_widget.dart';
part '../views/widgets/build_register_dont_have_account_widget.dart';
part '../views/widgets/build_register_email_field_widget.dart';
part '../views/widgets/build_register_lottie_animation.dart';
part '../views/widgets/build_register_password_field_widget.dart';
part '../views/widgets/build_register_terms_and_conditions_widget.dart';
part '../views/widgets/build_register_title_widget.dart';
