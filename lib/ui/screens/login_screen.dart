import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/asset_constants.dart';
import '../../constants/color_constants.dart';
import '../widgets/buttons/wide_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetConstants.iconLogo,
                    width: 140,
                  ),
                  Space.vertical(size: 52.0),
                  const UnderlineTextField(
                    hintText: 'Email',
                  ),
                  Space.vertical(size: 8.0),
                  const UnderlineTextField(
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  Space.vertical(size: 24.0),
                  WideButton(
                    onPressed: () {
                      Get.offAll(const HomeScreen());
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
        ),
      ),
    );
  }
}
