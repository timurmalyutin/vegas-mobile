import 'package:go_router/go_router.dart';
import '../features/promotions/promotion_feature.dart';
import '../features/user_selector/screens/user_selector_screen.dart';
import '../features/splash/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/user',
      name: 'user_selector',
      builder: (context, state) => const UserSelectorScreen(),
    ),
    GoRoute(
      path: '/promotions',
      name: 'promotions',
      builder: (context, state) => const PromotionsScreen(),
    ),
  ],
);
