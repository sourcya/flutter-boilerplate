import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_scaffold.dart';
import 'package:flutter_boilerplate/core/widgets/custom_app_bar.dart';
import 'package:playx/playx.dart';
import 'package:playx_navigation/playx_navigation.dart';

import '../../../../core/data_state/models/data_state.dart';
import '../../../../core/data_state/widgets/rx_data_state_widget.dart';
import '../../../../core/resources/colors/app_colors.dart';
import '../../../../core/widgets/components/custom_card.dart';
import '../../../../core/widgets/components/custom_text.dart';
import '../../../wishlist/data/model/ui/wishlist.dart';
import '../../../wishlist/data/repository/wishlist_repository.dart';
import '../../data/model/dashboard.dart';

part '../binding/dashboard_binding.dart';
part '../controller/dashboard_controller.dart';
part '../view/dashboard_view.dart';
