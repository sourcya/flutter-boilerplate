import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/app/profile_update/data/repository/profile_repository.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playx/playx.dart';

// Your app imports
part '../bindings/edit_profile_binding.dart';
part '../controllers/edit_profile_controller.dart';
part '../views/edit_profile_view.dart';
part '../views/widgets/build_profile_image_section.dart';
part '../views/widgets/build_profile_form_section.dart';
part '../views/widgets/build_profile_field_widget.dart';
part '../views/widgets/build_save_button.dart';
part '../views/widgets/build_animated_header.dart';
part '../views/widgets/build_skeleton_loader.dart';
