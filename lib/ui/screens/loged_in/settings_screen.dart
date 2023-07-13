import 'package:connacta/constants/asset_constants.dart';
import 'package:connacta/constants/color_constants.dart';
import 'package:connacta/ui/widgets/space.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Me"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: ColorConstants.white,
                  image: const DecorationImage(
                    image: NetworkImage(AssetConstants.defaultProfile),
                  ),
                ),
              ),
              Space.vertical(size: 16.0),
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'barlow',
                ),
              ),
              Space.vertical(size: 32.0),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Profile Settings",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
