import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/playx_binding.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/navigation/app_navigation.dart';
import '../../../../../../core/resources/assets/assets.dart';
import '../../../../../../core/resources/colors/app_colors.dart';
import '../../../../../../core/resources/translation/app_locale_config.dart';
import '../../../../../../core/resources/translation/app_translations.dart';
import '../../../../../../core/utils/alert.dart';
import '../../../../../../core/widgets/components/custom_text.dart';
import '../../../../../../core/widgets/components/text_field.dart';
import '../../../data/models/api_user.dart';
import '../../../data/models/login_method.dart';
import '../../../data/repo/auth_repository.dart';

part '../bindings/login_binding.dart';
part '../controllers/login_controller.dart';
part '../views/login_view.dart';
part '../views/widgets/build_choose_login_method_widget.dart';
part '../views/widgets/build_login_button.dart';
part '../views/widgets/build_login_email_field.dart';
part '../views/widgets/build_login_lottie_animation.dart';
part '../views/widgets/build_login_method_button.dart';
part '../views/widgets/build_login_password_field.dart';
part '../views/widgets/build_login_register_now.dart';
part '../views/widgets/build_login_title.dart';
part '../views/widgets/build_login_with_email_widget.dart';
