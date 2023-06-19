import 'package:daily_driver/pages/create_account.dart';
import 'package:daily_driver/pages/home_page.dart';
import 'package:daily_driver/pages/identity_verification.dart';
import 'package:daily_driver/pages/location_setup.dart';
import 'package:daily_driver/pages/notification_page.dart';
import 'package:daily_driver/pages/profile.dart';
import 'package:daily_driver/pages/splash_screen.dart';
import 'package:daily_driver/pages/login_user.dart';
import 'package:daily_driver/pages/user_type.dart';
import 'package:daily_driver/pages/wallet_page.dart';
import 'package:go_router/go_router.dart';
import 'package:daily_driver/const/routes_names.dart';

class PageRoutes {
  static GoRouter goRoute = GoRouter(
    routes: [
      GoRoute(
        path: RoutesName.splash,
        builder: (
          context,
          state,
        ) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: RoutesName.userType,
        builder: (
          context,
          state,
        ) =>
            const UserTypeScreen(),
      ),
      GoRoute(
        path: RoutesName.loginUserAccount,
        builder: (
          context,
          state,
        ) =>
            const LoginUserAccount(),
      ),
      GoRoute(
        path: RoutesName.createAccont,
        builder: (context, state) => const CreateAccount(),
      ),
      GoRoute(
        path: RoutesName.homePage,
        builder: (
          context,
          state,
        ) =>
            const HomePage(),
      ),
      GoRoute(
        path: RoutesName.profile,
        builder: (context, state) => const Profile(),
      ),
      GoRoute(
        path: RoutesName.notification,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: RoutesName.walletPage,
        builder: (context, state) => const WalletPage(),
      ),
      GoRoute(
        path: RoutesName.identityVerfication,
        builder: (
          context,
          state,
        ) =>
            const IdentityVerification(),
      ),
      GoRoute(
        path: RoutesName.locationSetup,
        builder: (context, state) => const LocationSetup(),
      )
    ],
  );
}
