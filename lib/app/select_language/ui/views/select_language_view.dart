import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/resources/colors/app_color_scheme.dart';
import '../controllers/select_language_controller.dart';

class SelectLanguageView extends GetView<SelectLanguageController> {
  const SelectLanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Language',
          style: context.h6?.copyWith(
            fontSize: 18,
            color: colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 25,
              ),
              ...[
                'English',
                'French',
                'Arabic',
                'Spanish',
                'Dutch',
              ]
                  .map(
                    (e) => ListTile(
                      leading: Radio(
                        groupValue: controller.selectedLang.value,
                        activeColor: colorScheme.secondary,
                        value: e,
                        onChanged: (_) => controller.selectedLang.value = e,
                      ),
                      onTap: () => controller.selectedLang.value = e,
                      title: Text(
                        e,
                        style: context.bodyText1?.copyWith(
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
        },
      ),
    );
  }
}
