import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/widgets/custom_app_bar.dart';
import 'package:playx/playx.dart';

import '../../../../core/data_state/models/data_error.dart';
import '../../../../core/data_state/models/data_state.dart';
import '../../../../core/data_state/widgets/rx_data_state_widget.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../auth/data/models/user.dart';
import '../../../auth/data/repo/google_auth_repository.dart';

part  '../bindings/home_binding.dart';
part  '../controllers/home_controller.dart';
part '../views/home_view.dart';
part '../views/widgets/build_bottom_navigation_bar.dart';
