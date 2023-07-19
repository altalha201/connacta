import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../constants/color_constants.dart';
import '../../../controller/logic_controller/signup_controller.dart';
import '../../widgets/appbars/appbars.dart';
import '../../widgets/buttons/wide_button.dart';
import '../../widgets/loading_widgets/center_loading.dart';
import '../../widgets/space.dart';
import '../../widgets/text_fields/border_text_field.dart';
import 'photo_select_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String _selectedGender = "others";

  final TextEditingController _firstNameET = TextEditingController();
  final TextEditingController _lastNameET = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _dobET = TextEditingController();

  final GlobalKey<FormState> _profileCreateKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  Future<void> onDateSelectTap() async {
    DateTime initial = DateTime.now().subtract(const Duration(days: 6574));
    DateTime last = initial.add(const Duration(days: 1460));
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1971),
      lastDate: last,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat.yMMMd("en_US").format(pickedDate);
      setState(() {
        _dobET.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars.centerTitled(title: "Create Your Profile"),
      body: GetBuilder<SignupController>(builder: (signup) {
        if (signup.creatingProfile) {
          return const CenterLoading();
        }
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _profileCreateKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: BorderTextField(
                          hintText: "First Name",
                          controller: _firstNameET,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "First name must needed";
                            }
                            return null;
                          },
                        ),
                      ),
                      Space.horizontal(size: 8.0),
                      Expanded(
                        child: BorderTextField(
                          hintText: "Last Name",
                          controller: _lastNameET,
                        ),
                      ),
                    ],
                  ),
                  Space.vertical(size: 8.0),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: BorderTextField(
                            hintText: "Country Code",
                            readOnly: true,
                            controller: _countryCode,
                            validator: (value) {
                              if(value?.isEmpty ?? true) {
                                return 'Select Country Code';
                              }
                              return null;
                            },
                            onTap: () {
                              Get.bottomSheet(
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                        color: ColorConstants.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Select Country Code",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: ColorConstants.black),
                                        ),
                                        Space.vertical(size: 32.0),
                                        ListTile(
                                          leading: const Flag.fromString(
                                            "BD",
                                            width: 100,
                                          ),
                                          title: const Text("Bangladesh"),
                                          subtitle: const Text("+880"),
                                          onTap: () {
                                            setState(() {
                                              _countryCode.text = "+880";
                                            });
                                            Get.back();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Flag.fromString(
                                            "IN",
                                            width: 100,
                                          ),
                                          title: const Text("India"),
                                          subtitle: const Text("+91"),
                                          onTap: () {
                                            setState(() {
                                              _countryCode.text = "+91";
                                            });
                                            Get.back();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Flag.fromString(
                                            "PK",
                                            width: 100,
                                          ),
                                          title: const Text("Pakistan"),
                                          subtitle: const Text("+92"),
                                          onTap: () {
                                            setState(() {
                                              _countryCode.text = "+92";
                                            });
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  backgroundColor: Colors.transparent);
                            },
                          ),),
                      Space.horizontal(size: 8.0),
                      Expanded(
                        flex: 2,
                        child: BorderTextField(
                          hintText: "Phone Number",
                          controller: _phoneNumber,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  Space.vertical(size: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: BorderTextField(
                          hintText: "Select Date of Birth",
                          readOnly: true,
                          controller: _dobET,
                          validator: (value) {
                            if (_dobET.text.isEmpty) {
                              return "Date of birth needed";
                            }
                            return null;
                          },
                        ),
                      ),
                      Space.horizontal(size: 8.0),
                      IconButton(
                        onPressed: onDateSelectTap,
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
                  ),
                  Space.vertical(size: 32.0),
                  WideButton(
                    onPressed: () async {
                      if (_profileCreateKey.currentState!.validate()) {
                        final name = "${_firstNameET.text} ${_lastNameET.text}";
                        final phone =
                            "${_countryCode.text} ${_phoneNumber.text}";
                        final response = await signup.createProfile(
                            name: name,
                            phoneNumber: phone,
                            dob: _dobET.text,
                            gender: _selectedGender);
                        if(response) {
                          Get.to(PhotoSelectScreen(name: name, email: signup.email,));
                        }
                      }
                    },
                    buttonText: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
