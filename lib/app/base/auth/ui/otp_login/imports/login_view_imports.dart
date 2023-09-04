
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/navigation/app_navigation.dart';
import '../../../../../../core/resources/assets/assets.dart';
import '../../../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../../../core/resources/translation/app_translations.dart';
import '../../../../../../core/utils/alert.dart';
import '../../../../../../core/widgets/components/custom_elevated_button.dart';
import '../../../../../../core/widgets/components/custom_scaffold.dart';
import '../../../../../../core/widgets/components/custom_text.dart';
import '../../../../../../core/widgets/components/text_field.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';

part '../bindings/otp_login_binding.dart';
part '../controllers/otp_login_controller.dart';
part '../views/otp_login_view.dart';
part '../views/widgets/build_login_button.dart';
part '../views/widgets/build_login_lottie_animation.dart';
part '../views/widgets/build_login_mobile_text_field.dart';
part '../views/widgets/build_login_subtitle_text.dart';
part '../views/widgets/build_login_text.dart';
