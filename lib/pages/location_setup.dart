import 'dart:developer';

import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/functions/location_getter.dart';
import 'package:daily_driver/model/location_model.dart';
import 'package:daily_driver/widgets/custom_button.dart';
import 'package:daily_driver/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';

class LocationSetup extends StatelessWidget {
  const LocationSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: const Text(
          "Location Setup",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const CustomTextForm(
              minLenght: 2,
              icon: Icon(
                Icons.location_city,
                color: AppColors.primaryColor,
              ),
              hintText: "Input Your Location",
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomButton(
              title: 'Use My Input Location',
              backGroundColor: AppColors.black,
              textColor: AppColors.white,
              padding: EdgeInsets.all(20),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () async {
                GetUserLocation getUserLocation = GetUserLocation();
                LocationModel? locationModel =
                    await getUserLocation.getLocation();
                if (locationModel != null) {
                  log(locationModel.latitude.toString());
                  log(locationModel.longitude.toString());
                  ReverseGeolocation reverseGeolocation = ReverseGeolocation();
                  await reverseGeolocation.reverseGeolocation(
                      locationModel: locationModel);
                }
              },
              title: 'Get My Location',
              backGroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              padding: const EdgeInsets.all(20),
            )
          ],
        ),
      ),
    );
  }
}
