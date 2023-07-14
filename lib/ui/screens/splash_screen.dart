import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/asset_constants.dart';
import 'logged_in/home_screen.dart';
// import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2)).then((value) {
          // Get.offAll(const LoginScreen(), transition: Transition.downToUp);
          Get.offAll(const HomeScreen(), transition: Transition.downToUp);
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  AssetConstants.iconLogo,
                  width: 180,
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              replacement: const SizedBox.shrink(),
              child: const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ),
            Visibility(
              visible: isLoading,
              replacement: const SizedBox.shrink(),
              child: const SizedBox(
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
