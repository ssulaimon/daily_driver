// ignore_for_file: use_build_context_synchronously

import 'package:daily_driver/authentication/firebase_email_auth.dart';
import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/const/routes_names.dart';
import 'package:daily_driver/data_base/firebase_data_base.dart';
import 'package:daily_driver/functions/image_picker_function.dart';
import 'package:daily_driver/functions/text_form_validator.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:daily_driver/widgets/custom_button.dart';
import 'package:daily_driver/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name = FirebaseEmailAuth.userName;
  String? email = FirebaseEmailAuth.userEmail;
  String? phoneNumber = FirebaseEmailAuth.userPhoneNumber;
  // String? profilePicture = FirebaseEmailAuth.userProfileImage;
  bool? identity;
  String? location;

  userVerifed() async {
    DataBase db = DataBase();
    Map<String, dynamic>? verifed = await db.isUserVerified();
    setState(() {
      identity = verifed?['verified'];
    });
  }

  @override
  void initState() {
    super.initState();
    userVerifed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Stack(
              children: [
                const Hero(
                  tag: 'profileImage',
                  child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 50,
                      backgroundImage: AssetImage(
                        'images/icons/avatar.png',
                      )),
                ),
                Positioned(
                  top: 70,
                  left: 50,
                  child: IconButton(
                    onPressed: () async {
                      XFile? file = await ImagePickerFunction.imagepicker();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: AnotherStepper(
              inActiveBarColor: AppColors.primaryColor,
              stepperDirection: Axis.vertical,
              iconWidth: 30,
              iconHeight: 30,
              stepperList: [
                StepperData(
                  iconWidget: const ImageIcon(
                    AssetImage(
                      'images/icons/profile.png',
                    ),
                    color: AppColors.primaryColor,
                  ),
                  title: StepperText(
                    name!,
                  ),
                  subtitle: StepperText(
                    'Full Name',
                  ),
                ),
                StepperData(
                  iconWidget: GestureDetector(
                    onTap: () {
                      if (phoneNumber != null) {
                        showSnackBarErorr(
                            context: context,
                            message: 'Phone Number already attached');
                      } else {
                        updateEmail(
                          context: context,
                          title: 'Update Phone Number',
                          icon: const Icon(Icons.phone),
                          hintText: 'Enter Your Phone Number',
                        );
                      }
                    },
                    child: const ImageIcon(
                      AssetImage(
                        'images/icons/phone.png',
                      ),
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: StepperText(
                    phoneNumber ?? 'Phone Number not set',
                  ),
                  subtitle: StepperText(
                    'Phone number',
                  ),
                ),
                StepperData(
                  iconWidget: GestureDetector(
                    onTap: () {
                      if (email != null) {
                        showSnackBarErorr(
                          context: context,
                          message: 'Email address already attched',
                        );
                      } else {
                        updateEmail(
                          context: context,
                          title: 'Add email address',
                          icon: const Icon(
                            Icons.email,
                          ),
                          hintText: 'Enter email address',
                        );
                      }
                    },
                    child: const ImageIcon(
                      AssetImage(
                        'images/icons/email.png',
                      ),
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: StepperText(
                    email ?? 'No email attached',
                  ),
                  subtitle: StepperText(
                    'Phone number',
                  ),
                ),
                StepperData(
                  iconWidget: GestureDetector(
                    onTap: () {
                      if (phoneNumber == null) {
                        showSnackBarErorr(
                            context: context,
                            message: "Please add phone number");
                      } else if (email == null) {
                        showSnackBarErorr(
                            context: context,
                            message: 'Please add email address');
                      } else if (identity == true) {
                        showSnackBarErorr(
                            context: context, message: 'Account Verified');
                      } else {
                        context.push(
                          RoutesName.identityVerfication,
                        );
                      }
                    },
                    child: const ImageIcon(
                      AssetImage(
                        'images/icons/id_card.png',
                      ),
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: StepperText(
                    identity == null ? 'Not verified' : "Verified",
                  ),
                  subtitle: StepperText(
                    'Identity card',
                  ),
                ),
                StepperData(
                  iconWidget: GestureDetector(
                    onTap: () {
                      if (identity == null) {
                        showSnackBarErorr(
                            context: context,
                            message: 'Please Verify Identity First');
                      } else {
                        context.push(
                          RoutesName.locationSetup,
                        );
                      }
                    },
                    child: const ImageIcon(
                      AssetImage(
                        'images/icons/location.png',
                      ),
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: StepperText(
                    location ?? 'Not allowed',
                  ),
                  subtitle: StepperText(
                    'Location',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: AppColors.white,
    );
  }
}

Future<void> updateEmail({
  Function()? onTap,
  required BuildContext context,
  required String title,
  required Icon icon,
  required String hintText,
}) async {
  double height = MediaQuery.of(context).size.height;
  var loader = Provider.of<LoaderState>(context, listen: false);
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  return await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        title,
      ),
      content: Builder(
        builder: (context) => SizedBox(
          height: height * 0.2,
          child: Form(
            key: form,
            child: Column(
              children: [
                CustomTextForm(
                  textEditingController: email,
                  validator: (mail) => TextFormValidator.emailValidator(mail),
                  icon: icon,
                  hintText: hintText,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  padding: const EdgeInsets.all(10),
                  backGroundColor: AppColors.black,
                  onTap: () async {
                    bool verifed = await FirebaseEmailAuth.updateEMailAddress(
                      context: context,
                      email: email.text,
                    );
                    if (verifed) {
                      showSnackBarErorr(
                          context: context, message: 'Account Verified');
                    } else {
                      showSnackBarErorr(
                          context: context, message: 'Something Went Wrong');
                    }
                  },
                  title: 'Update',
                  textColor: AppColors.white,
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
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void showSnackBarErorr(
    {required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
