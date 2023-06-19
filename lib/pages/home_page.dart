// ignore_for_file: use_build_context_synchronously

import 'package:daily_driver/authentication/firebase_email_auth.dart';
import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/const/routes_names.dart';
import 'package:daily_driver/widgets/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        elevation: 0.0,
        backgroundColor: AppColors.white,
      ),
      drawer: const Drawer(
        child: NavigatorItems(),
      ),
    );
  }
}

class NavigatorItems extends StatelessWidget {
  const NavigatorItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Hero(
                    tag: 'profileImage',
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      backgroundImage: AssetImage(
                        'images/icons/avatar.png',
                      ),
                      radius: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    FirebaseEmailAuth.userName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailsWidget(
                    icon: 'images/icons/rating.png',
                    title: 'Rating',
                    detail: '0.0',
                  ),
                  DetailsWidget(
                    icon: 'images/icons/trip.png',
                    title: 'Trip',
                    detail: '1',
                  ),
                  DetailsWidget(
                    icon: 'images/icons/distance.png',
                    title: 'Distance',
                    detail: '0.0km',
                  )
                ],
              ),
            ],
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              onTap: () => context.push(
                RoutesName.profile,
              ),
              leading: Image.asset('images/icons/profile.png'),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () => context.push(
                RoutesName.walletPage,
              ),
              leading: Image.asset('images/icons/wallet.png'),
              title: const Text(
                'Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () => context.push(
                RoutesName.notification,
              ),
              leading: Image.asset('images/icons/notification.png'),
              title: const Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await FirebaseEmailAuth.logout();
                context.go(
                  RoutesName.loginUserAccount,
                );
              },
              leading: Image.asset('images/icons/logout.png'),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
