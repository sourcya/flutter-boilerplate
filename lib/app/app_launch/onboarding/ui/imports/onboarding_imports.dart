import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:playx/playx.dart';
import 'package:flutter_boilerplate/app/app_launch/onboarding/data/model/onboarding.dart';
import 'package:flutter_boilerplate/app/app_launch/onboarding/ui/view/widgets/onboarding_heading_rich_text_widget.dart';
import 'package:flutter_boilerplate/core/config/constant.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

part '../../data/model/onboarding_pages.dart';
part '../binding/onboarding_binding.dart';
part '../controller/onboarding_controller.dart';
part '../controller/onboarding_slides_carousel_controller.dart';
part '../view/components/onboarding_slide_component.dart';
part '../view/onboarding_view.dart';
part '../view/widgets/build_onboarding_page_view_widget.dart';
part '../view/widgets/onboarding_hero_svg_widget.dart';
part '../view/widgets/onboarding_segment_progress_widget.dart';
part '../view/widgets/onboarding_slides_widget.dart';
part '../view/widgets/onboarding_slide_footer_nav_widget.dart';
part '../view/widgets/onboarding_slide_portrait_layout_widget.dart';
part '../view/widgets/onboarding_slide_toolbar_widget.dart';
part '../view/widgets/page/view_dashboard_button.dart';
