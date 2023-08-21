
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/resources/assets/assets.dart';
import '../../../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../../../core/resources/translation/app_translations.dart';
import '../../../../../../core/widgets/text_field.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/core/utils/alert.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../../core/navigation/app_navigation.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';

part '../views/otp_login_view.dart';
part '../controllers/otp_login_controller.dart';
part '../bindings/otp_login_binding.dart';

part '../views/widgets/build_login_button.dart';
part '../views/widgets/build_login_lottie_animation.dart';
part '../views/widgets/build_login_mobile_text_field.dart';
part '../views/widgets/build_login_subtitle_text.dart';
part '../views/widgets/build_login_text.dart';
