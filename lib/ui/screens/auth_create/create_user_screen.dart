import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../../controller/logic_controller/signup_controller.dart';
import '../../widgets/buttons/wide_button.dart';
import '../../widgets/loading_widgets/center_loading.dart';
import '../../widgets/space.dart';
import '../../widgets/text_fields/underline_text_field.dart';
import 'create_profile_screen.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  bool _passwordVisibility = true, _confirmVisibility = true;

  final GlobalKey<FormState> _createAuthKey = GlobalKey<FormState>();
  final TextEditingController _emailEt = TextEditingController();
  final TextEditingController _passEt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SignupController>(builder: (signupController) {
          if (signupController.creatingAuth) {
            return const CenterLoading();
          }
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Form(
                key: _createAuthKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetConstants.iconLogo,
                        width: 140,
                      ),
                      Space.vertical(size: 52.0),
                      UnderlineTextField(
                        hintText: 'Email',
                        controller: _emailEt,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Email";
                          }
                          if (!EmailValidator.validate(_emailEt.text.trim())) {
                            return "Enter a valid Email";
                          }
                          return null;
                        },
                      ),
                      Space.vertical(size: 8.0),
                      UnderlineTextField(
                        hintText: 'Password',
                        obscureText: _passwordVisibility,
                        controller: _passEt,
                        validator: (value) {
                          if ((value?.length ?? 0) < 6) {
                            return 'Password must by 6 digit or more';
                          }
                          return null;
                        },
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisibility = !_passwordVisibility;
                            });
                          },
                          icon: Icon(
                            _passwordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      Space.vertical(size: 8.0),
                      UnderlineTextField(
                        hintText: 'Renter Password',
                        obscureText: _confirmVisibility,
                        validator: (value) {
                          if ((value ?? '') != _passEt.text) {
                            return 'Password dose not match';
                          }
                          return null;
                        },
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmVisibility = !_confirmVisibility;
                            });
                          },
                          icon: Icon(
                            _confirmVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      Space.vertical(size: 24.0),
                      WideButton(
                        onPressed: () async {
                          if (_createAuthKey.currentState!.validate()) {
                            final response = await signupController.createAuth(
                                email: _emailEt.text.trim(),
                                password: _passEt.text);
                            if (response) {
                              Get.to(const CreateProfileScreen());
                            }
                          }
                        },
                        buttonText: 'Create Your Account',
                      ),
                      Space.vertical(size: 24.0),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Have an account? Login.."),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
