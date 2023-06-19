// ignore_for_file: use_build_context_synchronously

import 'package:daily_driver/authentication/firebase_phone_auth.dart';
import 'package:daily_driver/const/colors.dart';
import 'package:daily_driver/functions/authentication_button.dart';
import 'package:daily_driver/functions/text_form_validator.dart';
import 'package:daily_driver/state_manager/buttons_state.dart';
import 'package:daily_driver/state_manager/loader_state.dart';
import 'package:daily_driver/widgets/custom_button.dart';
import 'package:daily_driver/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Center(
                    child: Image.asset(
                      'images/icons/cars_colored.png',
                    ),
                  ),
                  const TabBar(
                    indicatorColor: AppColors.primaryColor,
                    tabs: [
                      Tab(
                        child: Text(
                          'Register with Email',
                          style: TextStyle(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Register with Phone',
                          style: TextStyle(
                            color: AppColors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.5,
                    child: const TabBarView(children: [
                      EmailRegistration(),
                      PhoneRegistration(),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailRegistration extends StatefulWidget {
  const EmailRegistration({super.key});

  @override
  State<EmailRegistration> createState() => _EmailRegistrationState();
}

class _EmailRegistrationState extends State<EmailRegistration> {
  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String buttonTitle = 'Create Account';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderState>(builder: (context, loader, child) {
      return Form(
        key: _key,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTextForm(
              textEditingController: email,
              validator: (mail) => TextFormValidator.emailValidator(mail),
              keyBoardType: TextInputType.emailAddress,
              icon: const Icon(
                Icons.email,
                color: AppColors.primaryColor,
              ),
              hintText: 'E-mail',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextForm(
              textEditingController: name,
              validator: (name) => TextFormValidator.nameValidator(name),
              keyBoardType: TextInputType.name,
              icon: const Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
              hintText: 'Name',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextForm(
              textEditingController: password,
              validator: (password) =>
                  TextFormValidator.passwordValidator(password),
              obsecure: true,
              icon: const Icon(
                Icons.key,
                color: AppColors.primaryColor,
              ),
              hintText: 'Password',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () async {
                if (_key.currentState!.validate()) {
                  String? message = await AuthenticationButton.createAccount(
                      context: context,
                      email: email.text,
                      password: password.text,
                      name: name.text);
                  if (message == null) {
                    setState(() {
                      buttonTitle = 'Account Created';
                    });
                  } else {
                    setState(() {
                      buttonTitle = message;
                    });
                  }
                }
              },
              textColor: AppColors.white,
              backGroundColor: AppColors.black,
              width: double.infinity,
              padding: const EdgeInsets.all(
                20,
              ),
              title: buttonTitle,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            )
          ],
        ),
      );
    });
  }
}

class PhoneRegistration extends StatefulWidget {
  const PhoneRegistration({super.key});

  @override
  State<PhoneRegistration> createState() => _PhoneRegistrationState();
}

class _PhoneRegistrationState extends State<PhoneRegistration> {
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController name = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var loader = Provider.of<LoaderState>(context);
    var buttonTitle = Provider.of<ButtonState>(context);
    return Form(
      key: _key,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextForm(
            textEditingController: phoneNumber,
            validator: (phone) => TextFormValidator.phoneNumberValidator(phone),
            keyBoardType: TextInputType.phone,
            icon: const Icon(
              Icons.phone,
              color: AppColors.primaryColor,
            ),
            hintText: 'Phone Number',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextForm(
            textEditingController: name,
            validator: (name) => TextFormValidator.nameValidator(name),
            keyBoardType: TextInputType.name,
            icon: const Icon(
              Icons.person,
              color: AppColors.primaryColor,
            ),
            hintText: 'Name',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              onTap: () async {
                if (_key.currentState!.validate()) {
                  FirebasePhoneAuth firebasePhoneAuth = FirebasePhoneAuth();
                  await firebasePhoneAuth.verifyPhoneNumber(
                    createAccount: true,
                    name: name.text,
                    phoneNumber: phoneNumber.text,
                    context: context,
                  );
                }
              },
              textColor: AppColors.white,
              backGroundColor: AppColors.black,
              width: double.infinity,
              padding: const EdgeInsets.all(
                20,
              ),
              title: buttonTitle.buttonTitle,
              child: loader.loading == false
                  ? null
                  : const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

Future<void> verifyCode({
  required BuildContext context,
  required String id,
  String? name,
  required bool createAccount,
}) async {
  TextEditingController code = TextEditingController();
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      title: const Text(
        'Please Enter Verification Code',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Builder(builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return SizedBox(
          width: width * 0.1,
          height: height * 0.3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: PinInputTextField(
                  controller: code,
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: PinListenColorBuilder(
                      AppColors.primaryColor,
                      AppColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () async {
                  if (createAccount) {
                    await FirebasePhoneAuth.createAccount(
                      context: context,
                      name: name!,
                      smsCode: code.text,
                      verificationId: id,
                    );
                    context.pop();
                  } else {
                    await FirebasePhoneAuth.loginToAccount(
                        context: context,
                        verificationId: id,
                        smsCode: code.text);
                    context.pop();
                  }
                },
                padding: const EdgeInsets.all(20),
                title: 'Continue',
                textColor: AppColors.white,
                backGroundColor: AppColors.primaryColor,
              )
            ],
          ),
        );
      }),
    ),
  );
}
