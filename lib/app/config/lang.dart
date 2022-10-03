import 'package:get/get_navigation/get_navigation.dart';
import 'package:playx/playx.dart';

class AppTrans extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'change_map_style': 'Change Map Style',
          'dashboard': 'Dashboard',
          'map': 'Map',
          'vehicles': 'Vehicles',
          'reports': 'Reports',
          'notificatios': 'Notificatios',
          'settings': 'Settings',
          'support': 'Support',
          'change_language'.tr: 'Change Language',
          'ar': 'العربية',
          'en': 'English',
          'home': 'Home',
          'logout': 'logout',
        },
        'ar': {
          'change_map_style': 'تغيير استايل الخريطة',
          'dashboard': 'لوحه التحكم',
          'map': 'الخريطه',
          'vehicles': 'السيارات',
          'reports': 'التقارير',
          'notificatios': 'الاشعارات',
          'settings': 'الاعدادات',
          'support': 'الدعم',
          'change_language': 'تغيير اللغه',
          'ar': 'العربية',
          'en': 'English',
          'logout': 'تسجيل الخروج',
        },
      };
}
