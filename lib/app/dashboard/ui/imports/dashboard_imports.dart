import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_scaffold.dart';
import 'package:flutter_boilerplate/core/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import '../../../../core/data_state/models/data_state.dart';
import '../../../../core/data_state/widgets/rx_data_state_widget.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/navigation/go_router/app_router.dart';
import '../../../../core/navigation/go_router/playx_binding.dart';
import '../../../../core/resources/colors/app_colors.dart';
import '../../../../core/widgets/components/custom_card.dart';
import '../../../../core/widgets/components/custom_text.dart';
import '../../../wishlist/data/model/ui/wishlist.dart';
import '../../../wishlist/data/repository/wishlist_repository.dart';
import '../../data/model/dashboard.dart';

part '../binding/dashboard_binding.dart';
part '../controller/dashboard_controller.dart';
part '../view/dashboard_view.dart';
