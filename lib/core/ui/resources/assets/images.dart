class Images {
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();

  final String placeholder = 'assets/images/placeholder.svg';
  final String profilePlaceholder = 'assets/images/profile_placeholder.svg';
  final String logoPng = 'assets/images/logo.png';
}

class Logo {
  Logo();
  String get logo => 'assets/images/logo/logo.svg';

  String get logoHorizontal => 'assets/images/logo/logo_horizontal.svg';

  String getLogo(bool isDark) => logo;

  String getHorizontalLogo(bool isDark) => logoHorizontal;
}

class Icons {
  static final Icons _instance = Icons._internal();

  factory Icons() {
    return _instance;
  }

  Icons._internal();

  final String apple = 'assets/images/icons/apple.svg';
  final String badgeCheck = 'assets/images/icons/badge-check.svg';
  final String bellDot = 'assets/images/icons/bell-dot.svg';
  final String bell = 'assets/images/icons/bell.svg';
  final String crown = 'assets/images/icons/crown.svg';
  final String faceId = 'assets/images/icons/face_id.svg';
  final String google = 'assets/images/icons/google.svg';
  final String icActive = 'assets/images/icons/ic_active.svg';
  final String icActiveTab = 'assets/images/icons/ic_active_tab.svg';
  final String icDashboard = 'assets/images/icons/ic_dashboard.svg';
  final String icLanguage = 'assets/images/icons/ic_language.svg';
  final String icMobile = 'assets/images/icons/ic_mobile.svg';
  final String icPanel = 'assets/images/icons/ic_panel.svg';
  final String icSettings = 'assets/images/icons/ic_settings.svg';
  final String icTable = 'assets/images/icons/ic_table.svg';
  final String icTheme = 'assets/images/icons/ic_theme.svg';
  final String icWarning = 'assets/images/icons/ic_warning.svg';
  final String lock = 'assets/images/icons/lock.svg';
  final String reset = 'assets/images/icons/reset.svg';
  final String search = 'assets/images/icons/search.svg';
  final String telephone = 'assets/images/icons/telephone.svg';
  final String whatsappBusiness = 'assets/images/icons/whatsapp-business.svg';

  final String expand = 'assets/images/icons/expand.svg';

  // Compatibility getters/fields
  String get logo => 'assets/images/logo/logo.svg';
  String get dashboard => icDashboard;
  String get settings => icSettings;
  String get table => icTable;
}
