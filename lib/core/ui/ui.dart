import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/model/loading_status.dart';
import 'package:flutter_boilerplate/app/app_launch/app/ui/imports/app_imports.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/resources/assets/animations.dart';
import 'package:flutter_boilerplate/core/ui/resources/assets/icons.dart' as asset;
import 'package:flutter_boilerplate/core/ui/resources/assets/images.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:playx/playx.dart';

part 'data_state/models/data_error.dart';
part 'data_state/models/data_state.dart';
part 'data_state/models/network_bound_resource.dart';
part 'data_state/models/rx_data_state.dart';
part 'data_state/sliver/data_state_widget.dart';
part 'data_state/sliver/rx_data_state_widget.dart';
part 'data_state/widgets/data_state_widget.dart';
part 'data_state/widgets/rx_data_state_widget.dart';
part 'resources/assets/assets.dart';
part 'resources/dimens/dimens.dart';
part 'resources/dimens/mobile_dimens.dart';
part 'resources/dimens/small_mobile_dimens.dart';
part 'resources/dimens/tablet_dimens.dart';
part 'resources/style/style.dart';
part 'theme/colors/app_colors.dart';
part 'theme/colors/dark_colors.dart';
part 'theme/colors/light_colors.dart';
part 'theme/dark_theme.dart';
part 'theme/light_theme.dart';
part 'theme/theme.dart';
part 'translation/app_locale_config.dart';
part 'translation/app_translations.dart';
part 'widgets/bottom_sheet/custom_modal.dart';
part 'widgets/bottom_sheet/widgets/build_modal_close_button.dart';
part 'widgets/bottom_sheet/widgets/build_modal_next_button.dart';
part 'widgets/bottom_sheet/widgets/build_modal_previous_button.dart';
part 'widgets/bottom_sheet/widgets/build_modal_title_widget.dart';
part 'widgets/components/custom_card.dart';
part 'widgets/components/custom_dialog.dart';
part 'widgets/components/custom_elevated_button.dart';
part 'widgets/components/custom_scaffold.dart';
part 'widgets/components/custom_text.dart';
part 'widgets/components/feature_chip.dart';
part 'widgets/components/filter_chip_selector.dart';
part 'widgets/components/filter_multiple_chip_selector.dart';
part 'widgets/components/text_field.dart';
part 'widgets/connection_status_widget.dart';
part 'widgets/custom_app_bar.dart';
part 'widgets/state/custom_loading.dart';
part 'widgets/state/empty_data_widget.dart';
part 'widgets/state/error_widget.dart';
part 'widgets/keyboard_visibility_padding.dart';
part 'widgets/state/loading_overlay.dart';
part 'widgets/state/no_internet_widget.dart';
part 'widgets/place_holder_image.dart';
part 'widgets/components/custom_page.dart';
part 'alerts/alert.dart';
