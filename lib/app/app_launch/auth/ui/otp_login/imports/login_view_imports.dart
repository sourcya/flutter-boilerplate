import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/auth0_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/test_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/network/network.dart' show ApiClient;
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

part '../bindings/otp_login_binding.dart';
part '../controllers/otp_login_controller.dart';
part '../views/otp_login_view.dart';
part '../views/widgets/build_login_button.dart';
part '../views/widgets/build_login_lottie_animation.dart';
part '../views/widgets/build_login_mobile_text_field.dart';
part '../views/widgets/build_login_subtitle_text.dart';
part '../views/widgets/build_login_text.dart';
