import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColors.primaryColor,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₦50000',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                      ImageIcon(
                        AssetImage(
                          'images/icons/wallet.png',
                        ),
                        color: AppColors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    width: 100,
                    padding: EdgeInsets.all(10),
                    title: 'Add Money',
                    backGroundColor: AppColors.black,
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Transactions'),
          ],
        ),
      ),
    );
  }
}
