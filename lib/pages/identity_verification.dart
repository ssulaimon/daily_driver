// ignore_for_file: use_build_context_synchronously

import 'package:daily_driver/authentication/firebase_email_auth.dart';
import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/data_base/firebase_data_base.dart';
import 'package:daily_driver/functions/image_picker_function.dart';
import 'package:daily_driver/functions/text_form_validator.dart';
import 'package:daily_driver/pages/profile.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:daily_driver/widgets/custom_button.dart';
import 'package:daily_driver/widgets/custom_dropdown.dart';
import 'package:daily_driver/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:provider/provider.dart';

class IdentityVerification extends StatefulWidget {
  const IdentityVerification({super.key});

  @override
  State<IdentityVerification> createState() => _IdentityVerificationState();
}

class _IdentityVerificationState extends State<IdentityVerification> {
  File? frontPicker;
  File? backPicker;
  TextEditingController name = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  DateTime dateTime = DateTime.now();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  String idType = "National Identity Card";
  String userName = FirebaseEmailAuth.userName!;

  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<LoaderState>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Identity Verification",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: Form(
        key: form,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: ListView(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.primaryColor,
                )),
                child: frontPicker != null
                    ? Image.file(frontPicker!)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Front pic of Identity card',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              XFile? pickImage =
                                  await ImagePickerFunction.imagepicker();
                              if (pickImage != null) {
                                setState(() {
                                  frontPicker = File(pickImage.path);
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.camera,
                              color: AppColors.primaryColor,
                            ),
                          )
                        ],
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: backPicker != null
                      ? Image.file(backPicker!)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Back pic of Identity card',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                XFile? pickImage =
                                    await ImagePickerFunction.imagepicker();
                                if (pickImage != null) {
                                  setState(() {
                                    backPicker = File(pickImage.path);
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.camera,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextForm(
                textEditingController: name,
                keyBoardType: TextInputType.name,
                icon: const Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Full Name',
                validator: (name) => TextFormValidator.nameValidator(name),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextForm(
                validator: (identityNumber) =>
                    TextFormValidator.identityNmuberVerification(
                        identityNumber),
                textEditingController: idNumber,
                keyBoardType: TextInputType.number,
                icon: const Icon(
                  Icons.numbers,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Idenitiy Card Number',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropDown(
                value: idType,
                onSave: (value) {
                  setState(() {
                    idType = value!;
                  });
                },
                validator: (type) => TextFormValidator.idTypeValidator(type),
                hint: 'Identity Card Type',
                dropdownMenuItem: const [
                  DropdownMenuItem(
                    value: 'National Identity Card',
                    child: Text('National Identity Card'),
                  ),
                  DropdownMenuItem(
                    value: "International Passport",
                    child: Text('International Passport'),
                  ),
                  DropdownMenuItem(
                    value: "Driver License",
                    child: Text('Driver License'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.0,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${dateTime.month.toString()}-${dateTime.day.toString()}-${dateTime.year.toString()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    const Text(
                      'DOB',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          DateTime? date = await showRoundedDatePicker(
                              theme: ThemeData(
                                primaryColor: AppColors.primaryColor,
                              ),
                              context: context,
                              firstDate: DateTime(1800));
                          if (date != null) {
                            setState(() {
                              dateTime = date;
                            });
                          }
                        },
                        icon: const Icon(Icons.date_range,
                            color: AppColors.black))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  title: 'Verify My Identity',
                  backGroundColor: AppColors.black,
                  textColor: AppColors.white,
                  padding: const EdgeInsets.all(20),
                  onTap: () async {
                    if (form.currentState!.validate() &&
                        frontPicker != null &&
                        backPicker != null) {
                      if (userName != name.text) {
                        showSnackBarErorr(
                            context: context,
                            message: "Name doesnot match account name");
                      } else {
                        DataBase db = DataBase();
                        bool verifed = await db.updateMyProfile(
                            data: {"verified": true}, context: context);
                        if (verifed) {
                          showSnackBarErorr(
                              context: context, message: "Account Verfied");
                        } else {
                          showSnackBarErorr(
                              context: context,
                              message: "Something Went Wrong");
                        }
                      }
                    } else {
                      showSnackBarErorr(
                          context: context, message: 'Check Identity Picture');
                    }
                  },
                  child: loader.loading == true
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> loadindDialogue({
  required BuildContext context,
}) async {
  await showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            content: Builder(builder: (context) {
              double height = MediaQuery.of(context).size.height;
              return SizedBox(
                height: height * 0.04,
                child: const Row(
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Loading',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ],
                ),
              );
            }),
          ));
}
