import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/api_user.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:flutter_boilerplate/core/utils/are_equals_validation.dart';
import 'package:playx/playx.dart';

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
