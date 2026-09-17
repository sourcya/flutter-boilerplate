import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/app/ui/imports/app_imports.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

part '../bindings/splash_binding.dart';
part '../controllers/splash_controller.dart';
part '../views/splash_view.dart';
part '../views/components/splash_portrait_body.dart';
part '../views/components/splash_landscape_body.dart';
part '../views/components/setup_card_body.dart';
part '../views/components/splash_logo_widget.dart';
part '../views/components/splash_center_content.dart';
part '../views/components/splash_powered_by_footer.dart';
part '../views/widgets/splash_preferences_animated_entry.dart';
part '../views/widgets/splash_preferences_mobile_bottom_sheet.dart';
part '../views/widgets/splash_preferences_inline_card.dart';
part '../views/widgets/splash_preferences_bottom_sheet.dart';
