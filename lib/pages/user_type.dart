import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/const/routes_names.dart';
import 'package:daily_driver/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  bool tappedPassengerButton = false;
  bool tappedDriverButton = false;
  continueAsADriver() {
    setState(
      () {
        tappedDriverButton = true;
      },
    );
  }

  continueAsAPassenger() {
    setState(
      () {
        tappedPassengerButton = true;
        context.go(
          RoutesName.loginUserAccount,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              backGroundColor:
                  tappedPassengerButton == true ? AppColors.black : null,
              textColor: tappedPassengerButton == true ? AppColors.white : null,
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              onTap: () => continueAsAPassenger(),
              title: 'I Am A Passenger',
              borderColor:
                  tappedPassengerButton == true ? null : AppColors.primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              backGroundColor:
                  tappedDriverButton == true ? AppColors.black : null,
              textColor: tappedDriverButton == true ? AppColors.white : null,
              onTap: () => continueAsADriver(),
              title: 'I Am A Driver',
              borderColor:
                  tappedDriverButton == true ? null : AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
