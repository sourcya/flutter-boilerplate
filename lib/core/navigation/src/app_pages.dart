part of '../navigation.dart';

class AppPages {
  AppPages._();

  static const initial = Paths.splash;
  static const homeRoute = Routes.dashboard;

  static final router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    routes: routes,
    observers: [
      SentryNavigatorObserver(),
    ],
    redirect: AuthGuard.redirect,
  );

  static final _homeNavigationRoutes = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) {
      return CustomPageScaffold.buildNavigationShellPage(
        state: state,
        navigationShell: navigationShell,
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.dashboard,
            name: Routes.dashboard,
            builder: (ctx, state) => const DashboardView(),
            binding: DashboardBinding(),
          ),
          // Extension point: reference/demo feature showcasing this boilerplate's
          // fetching + DataState conventions. Pushed as a simple top-level route,
          // not part of the home navigation shell.
          PlayxRoute(
            path: Paths.products,
            name: Routes.products,
            builder: (context, state) => const ProductsView(),
            binding: ProductsBinding(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.settings,
            name: Routes.settings,
            builder: (ctx, state) => const SettingsView(),
            binding: SettingsBinding(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.reports,
            name: Routes.reports,
            builder: (ctx, state) => const AppModulePage(
              title: AppTrans.reportsModuleTitle,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.analytics,
            name: Routes.analytics,
            builder: (ctx, state) => const AppModulePage(
              title: AppTrans.analyticsModuleTitle,
            ),
          ),
        ],
      ),
    ],
  );

  static final routes = [
    PlayxRoute(
      path: Paths.splash,
      name: Routes.splash,
      builder: (context, state) => const SplashView(),
      binding: SplashBinding(),
    ),
    PlayxRoute(
      path: Paths.login,
      name: Routes.login,
      builder: (context, state) => const LoginView(),
      binding: LoginBinding(),
    ),
    PlayxRoute(
      path: Paths.forgetPassword,
      name: Routes.forgetPassword,
      builder: (context, state) => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    PlayxRoute(
      path: Paths.passwordOtp,
      name: Routes.passwordOtp,
      builder: (context, state) => const PasswordOtpView(),
      binding: PasswordOtpBinding(),
    ),
    PlayxRoute(
      path: Paths.resetPassword,
      name: Routes.resetPassword,
      builder: (context, state) => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    PlayxRoute(
      path: Paths.onboarding,
      name: Routes.onboarding,
      builder: (context, state) => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),

    _homeNavigationRoutes,
  ];
}
