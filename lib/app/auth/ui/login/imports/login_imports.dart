
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/utils/app_utils.dart';
import '../../../../../core/widgets/components/text_field.dart';
import '../../../../../core/config/keys.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/resources/assets/assets.dart';
import '../../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/utils/alert.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';
import '../../../data/repo/biometric_auth_repository.dart';
import '../../../data/repo/google_auth_repository.dart';
import '../views/widgets/google_sign_in_button/google_sign_in_button.dart';

part  '../bindings/login_binding.dart';
part  '../controllers/login_controller.dart';
part '../views/login_view.dart';
part '../views/widgets/build_login_button.dart';
part '../views/widgets/build_login_email_field.dart';
part '../views/widgets/build_login_google_login_button.dart';
part '../views/widgets/build_login_lottie_animation.dart';
part '../views/widgets/build_login_password_field.dart';
part '../views/widgets/build_login_register_now.dart';
part '../views/widgets/build_login_title.dart';