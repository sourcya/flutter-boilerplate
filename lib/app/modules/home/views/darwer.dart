import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/routes/app_pages.dart';
import 'package:flutter_boilerplate/app/services/auth.dart';
import 'package:playx/playx.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              Get.find<AuthService>().cachedUser!.name,
            ),
            accountEmail: Text(
              Get.find<AuthService>().cachedUser!.email,
            ),
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
              Get.find<AuthService>().signOut();
              Get.offAllNamed(Routes.SIGN_IN);
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
