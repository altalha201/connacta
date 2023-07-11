import 'package:flutter/material.dart';

import '../../constants/asset_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = true;
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
                child: Image.asset(AssetConstants.iconLogo, width: 180,),
              ),
            ),
            Visibility(
                visible: isLoading,
                replacement: const SizedBox.shrink(),
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),),
            Visibility(
              visible: isLoading,
              replacement: const SizedBox.shrink(),
              child: const SizedBox(
                height: 32,
              ),),
          ],
        ),
      ),
    );
  }
}
