import 'package:flutter/material.dart';

import '../widgets/border_text_field.dart';
import '../widgets/space.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String _selectedGender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Your Profile"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                      child: BorderTextField(
                    hintText: "First Name",
                  )),
                  Space.horizontal(size: 8.0),
                  const Expanded(
                      child: BorderTextField(
                    hintText: "Last Name",
                  )),
                ],
              ),
              Space.vertical(size: 8.0),
              const BorderTextField(
                hintText: "Email",
                readOnly: true,
              ),
              Space.vertical(size: 8.0),
              Row(
                children: [
                  const Expanded(
                    child: BorderTextField(
                      hintText: "Select Date of Birth",
                      readOnly: true,
                    ),
                  ),
                  Space.horizontal(size: 8.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month_sharp),
                  ),
                ],
              ),
              Space.vertical(size: 8.0),
              const Text("Select Your Gender"),
              Space.vertical(size: 8.0),
              RadioListTile(
                title: const Text("Male"),
                value: "male",
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Female"),
                value: "female",
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Others"),
                value: "others",
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
