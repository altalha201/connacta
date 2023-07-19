import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/asset_constants.dart';
import '../../constants/color_constants.dart';
import '../../controller/logic_controller/login_controller.dart';
import '../widgets/buttons/wide_button.dart';
import '../widgets/loading_widgets/center_loading.dart';
import '../widgets/space.dart';
import '../widgets/text_fields/underline_text_field.dart';
import 'auth_create/create_user_screen.dart';
import 'logged_in/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisibility = true;
  final TextEditingController _emailET = TextEditingController();
  final TextEditingController _passET = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: GetBuilder<LoginController>(builder: (loginController) {

            if (loginController.loginInProgress) {
              return const CenterLoading();
            }

            return Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
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
                        controller: _emailET,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Enter Your Email";
                          }
                          if(!EmailValidator.validate(_emailET.text.trim())) {
                            return "Enter a valid Email";
                          }
                          return null;
                        },
                      ),
                      Space.vertical(size: 8.0),
                      UnderlineTextField(
                        hintText: 'Password',
                        obscureText: _passwordVisibility,
                        controller: _passET,
                        validator: (value) {
                          if((value?.length ?? 0) < 6) {
                            'Password must by 6 digit or more';
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
                      Space.vertical(size: 24.0),
                      WideButton(
                        onPressed: () async {
                          if(_loginFormKey.currentState!.validate()) {
                            final response = await loginController.login(_emailET.text.trim(), _passET.text);
                            if (response) {
                              Get.offAll(const HomeScreen());
                            }
                          }
                        },
                        buttonText: 'Login',
                      ),
                      Space.vertical(size: 16.0),
                      WideButton(
                        onPressed: () {
                          Get.to(const CreateUserScreen());
                        },
                        buttonText: 'Create Account',
                        backgroundColor: ColorConstants.green,
                      ),
                      Space.vertical(size: 24.0),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Forget Password?"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
