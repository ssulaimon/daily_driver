import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/const/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> pushToNextScreen() async {
    return Future.delayed(
      const Duration(seconds: 3),
      () => context.go(
        RoutesName.userType,
      ),
    );
  }

  @override
  void initState() {
    pushToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'images/icons/car.png',
            ),
          ),
          const Text(
            'Your Personal Drive....',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
