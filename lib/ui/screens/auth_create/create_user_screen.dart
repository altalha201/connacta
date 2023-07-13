import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/asset_constants.dart';
import '../../widgets/buttons/wide_button.dart';
import '../../widgets/space.dart';
import '../../widgets/text_fields/underline_text_field.dart';
import 'create_profile_screen.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
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
                  const UnderlineTextField(hintText: 'Email',),
                  Space.vertical(size: 8.0),
                  const UnderlineTextField(hintText: 'Password', obscureText: true,),
                  Space.vertical(size: 8.0),
                  const UnderlineTextField(hintText: 'Renter Password', obscureText: true,),
                  Space.vertical(size: 24.0),
                  WideButton(
                    onPressed: () {
                      Get.to(const CreateProfileScreen());
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
      ),
    );
  }
}
