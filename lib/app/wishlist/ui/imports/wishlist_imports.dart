import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/ui/wishlist.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import '../../../../core/data_state/models/data_error.dart';
import '../../../../core/data_state/models/data_state.dart';
import '../../../../core/data_state/widgets/rx_data_state_widget.dart';
import '../../../../core/navigation/go_router/playx_binding.dart';
import '../../../../core/widgets/components/custom_card.dart';
import '../../../../core/widgets/components/custom_text.dart';
import '../../data/repository/wishlist_repository.dart';

part '../binding/wishlist_binding.dart';
part '../controller/wishlist_controller.dart';
part '../view/wishlist_view.dart';
