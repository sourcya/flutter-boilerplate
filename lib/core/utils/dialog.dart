import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_color_scheme.dart';
import 'package:playx/playx.dart';

Future<bool> showConfirmDialog({
  required String title,
  required String message,
  required String lottie,
  required String confirmText,
  required String cancelText,
  required VoidCallback onConfirmed,
}) async {
  final context = Get.context!;
  bool isConfirmed = false;
  await Get.dialog(
    Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              height: context.height * .25,
              color: const Color(0xFF33CDBB),
              child: SizedBox(
                height: context.height * .2,
                child: Lottie.asset(lottie, width: double.infinity),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              width: double.infinity,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              width: double.infinity,
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          isConfirmed = true;
                          onConfirmed();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          confirmText,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          isConfirmed = false;
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          cancelText,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

  return isConfirmed;
}
