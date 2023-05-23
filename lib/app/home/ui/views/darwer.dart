import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/widgets/data_state_widget.dart';
import 'package:playx/playx.dart';

import '../controllers/home_controller.dart';

//drawer widget
class HomeDrawer extends GetView<HomeController> {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: DataStateWidget(
              data: controller.userState.value,
            ),
            accountEmail: DataStateWidget(
              data: controller.userState.value,
              onSuccess: (user) {
                return Text(
                  user.username ?? '',
                );
              },
              onLoading: (data) => Container(),
              onEmpty: (e) => Container(),
            ),
            // accountName: Obx(() {
            //   return Text(
            //     controller.user.value?.username ?? '',
            //   );
            // }),
            // accountEmail: Obx(() {
            //   return Text(
            //     controller.user.value?.email ?? '',
            //   );
            // }),
          ),
          DrawerItem(
            icon: Icons.dashboard,
            title: 'dashboard'.tr,
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.car_repair,
            title: 'vehicles'.tr,
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.report,
            title: 'reports'.tr,
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.notifications,
            title: 'notificatios'.tr,
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.support_agent,
            title: 'support'.tr,
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.logout,
            title: 'logout'.tr,
            onTap: () async {
              controller.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final bool enabled;

  const DrawerItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: enabled ? onTap : null,
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(title),
      ),
    );
  }
}
