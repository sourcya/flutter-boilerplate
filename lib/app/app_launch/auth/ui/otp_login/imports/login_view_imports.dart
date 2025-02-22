import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/api_user.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/core/navigation/app_navigation.dart';
import 'package:flutter_boilerplate/core/resources/assets/assets.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/utils/alert.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_elevated_button.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_text.dart';
import 'package:flutter_boilerplate/core/widgets/components/text_field.dart';
import 'package:playx/playx.dart';

part '../bindings/otp_login_binding.dart';
part '../controllers/otp_login_controller.dart';
part '../views/otp_login_view.dart';
part '../views/widgets/build_login_button.dart';
part '../views/widgets/build_login_lottie_animation.dart';
part '../views/widgets/build_login_mobile_text_field.dart';
part '../views/widgets/build_login_subtitle_text.dart';
part '../views/widgets/build_login_text.dart';
