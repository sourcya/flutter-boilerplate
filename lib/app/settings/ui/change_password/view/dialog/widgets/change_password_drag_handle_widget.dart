part of '../../../imports/change_password_imports.dart';

class ChangePasswordDragHandleWidget extends StatelessWidget {
  const ChangePasswordDragHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 16.0, vertical: 12.0),
      child: Center(
        child: Container(
          width: 48.r,
          height: 4.r,
          decoration: BoxDecoration(
            color: context.colors.mutedForeground,
            borderRadius: BorderRadius.circular(9999.r),
          ),
        ),
      ),
    );
  }
}
