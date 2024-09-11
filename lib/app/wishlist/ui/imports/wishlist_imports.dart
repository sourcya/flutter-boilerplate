import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/ui/wishlist.dart';
import 'package:playx/playx.dart';
import 'package:playx_navigation/playx_navigation.dart';

import '../../../../core/data_state/models/data_error.dart';
import '../../../../core/data_state/models/data_state.dart';
import '../../../../core/data_state/widgets/rx_data_state_widget.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/widgets/components/custom_card.dart';
import '../../../../core/widgets/components/custom_scaffold.dart';
import '../../../../core/widgets/components/custom_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repository/wishlist_repository.dart';

part '../binding/wishlist_binding.dart';
part '../binding/wishlist_details_binding.dart';
part '../controller/wishlist_controller.dart';
part '../view/wishlist_view.dart';
