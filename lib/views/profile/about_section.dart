import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:test/services/bloc/profile_form_bloc.dart';
import 'package:test/services/bloc/user_bloc.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/helper.dart';
import 'package:test/widgets/gradient_componentdart';
import 'package:test/widgets/svg_icon.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<String?> imagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64Encode(fileBytes);
      return base64String;
    } else {
      // User canceled the picker
      return null;
    }
  }

  Widget _buildFormRow({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.33),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDisplayRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.33),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.33),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(GetUserProfileEvent());
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorApp.emptyTextAreaBackgroundDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocConsumer<UserBloc, UserProfileState>(
                listener: (context, state) {
                  final userProfile = state.userProfile;

                  if (userProfile != null) {
                    if (userProfile.name != null) {
                      UpdateDisplayName(userProfile.name!);
                    }

                    if (userProfile.birthday != null) {
                      context.read<ProfileFormBloc>().add(
                            UpdateBirthday(DateTime.parse(userProfile.birthday!)),
                          );
                    }

                    context.read<ProfileFormBloc>().add(
                          const UpdateGender("Male"),
                        );

                    if (userProfile.height != null) {
                      context.read<ProfileFormBloc>().add(
                            UpdateHeight(userProfile.height!.toDouble()),
                          );
                    }

                    if (userProfile.weight != null) {
                      context.read<ProfileFormBloc>().add(
                            UpdateWeight(userProfile.weight!.toDouble()),
                          );
                    }
                  }
                },
                builder: (context, userState) {
                  return BlocConsumer<ProfileFormBloc, ProfileFormState>(
                    listener: (context, state) {
                      if (state.status == FormStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved successfully')),
                        );
                        context.read<UserBloc>().add(GetUserProfileEvent());
                      } else if (state.status == FormStatus.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage ?? 'Submission failed')),
                        );
                      }
                    },
                    builder: (context, formState) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8, top: 8),
                                    child: Text(
                                      "About",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: formState.status == FormStatus.open
                                      ? TextButton(
                                          onPressed: () => context.read<ProfileFormBloc>().add(
                                                SubmitForm(),
                                              ),
                                          child: const GradientText(
                                            'Save & Update',
                                            colors: ColorApp.goldenGradientColorList,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () => context.read<ProfileFormBloc>().add(
                                                const UpdateFormStatus(FormStatus.open),
                                              ),
                                          icon: const SvgIcon('edit', width: 17, height: 17, color: Colors.white),
                                        ),
                                ),
                              ],
                            ),
                            if (userState.userProfile != null && FormStatus.open != formState.status)
                              Column(children: [
                                _buildProfileDisplayRow(label: "Display Name", value: userState.userProfile?.name ?? ""),
                                _buildProfileDisplayRow(
                                    label: "Birthday",
                                    value: userState.userProfile?.birthday != null
                                        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(userState.userProfile!.birthday!))
                                        : ""),
                                _buildProfileDisplayRow(
                                    label: "Horoscope",
                                    value: (userState.userProfile!.birthday != null)
                                        ? getHoroscope(DateTime.parse(userState.userProfile!.birthday!))
                                        : formState.birthday != null
                                            ? getHoroscope(formState.birthday!)
                                            : '--'),
                                _buildProfileDisplayRow(
                                    label: "Zodiac",
                                    value: (userState.userProfile!.birthday != null)
                                        ? getZodiac(DateTime.parse(userState.userProfile!.birthday!))
                                        : formState.birthday != null
                                            ? getZodiac(formState.birthday!)
                                            : '--'),
                                _buildProfileDisplayRow(label: "Height", value: userState.userProfile?.height.toString() ?? ""),
                                _buildProfileDisplayRow(label: "Weight", value: userState.userProfile?.weight.toString() ?? ""),
                              ]),
                            if (userState.userProfile == null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Add in your info to help people get to know you better",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.52),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            if (formState.status == FormStatus.open) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      imagePicker().then((image) {
                                        if (image == null) return;
                                        context.read<UserBloc>().add(UpdateUserImage(image: image));
                                      });
                                      debugPrint('State user Profile ${userState.userProfile?.image}');
                                    },
                                    child: SizedBox(
                                      height: 57,
                                      width: 57,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(17),
                                        ),
                                        child: const GradientIcon(icon: CupertinoIcons.plus, colors: ColorApp.goldenGradientColorList),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Display Name Field
                              _buildFormRow(
                                label: 'Display Name',
                                child: FormBuilderTextField(
                                  name: 'display_name',
                                  initialValue: userState.userProfile?.name,
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    focusColor: Colors.white,
                                    hintText: 'Enter your display name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: 'Display name is required'),
                                    FormBuilderValidators.minLength(2, errorText: 'Name too short'),
                                  ]),
                                  onChanged: (value) {
                                    context.read<ProfileFormBloc>().add(
                                          UpdateDisplayName(value ?? ''),
                                        );
                                  },
                                ),
                              ),

                              // Gender Field
                              _buildFormRow(
                                label: 'Gender',
                                child: PopupMenuButton<String>(
                                  position: PopupMenuPosition.under,
                                  initialValue: formState.gender.isEmpty ? null : formState.gender,
                                  onSelected: (String value) {
                                    context.read<ProfileFormBloc>().add(UpdateGender(value));
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return ['Male', 'Female'].map<PopupMenuItem<String>>((String gender) {
                                      return PopupMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      );
                                    }).toList();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white.withOpacity(0.22)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formState.gender.isEmpty ? 'Select Gender' : formState.gender,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Birthday Field
                              _buildFormRow(
                                  label: 'Birthday',
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Select your birthday',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    controller: TextEditingController(
                                      text: userState.userProfile!.birthday != null
                                          ? DateFormat('yyyy-MM-dd').format(DateTime.parse(userState.userProfile!.birthday!))
                                          : formState.birthday != null
                                              ? DateFormat('yyyy-MM-dd').format(formState.birthday!)
                                              : '',
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: userState.userProfile!.birthday != null
                                            ? DateTime.parse(userState.userProfile!.birthday!)
                                            : DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );

                                      if (pickedDate != null) {
                                        context.read<ProfileFormBloc>().add(UpdateBirthday(pickedDate));
                                      }
                                    },
                                  )),

                              // Horoscope Field
                              _buildFormRow(
                                label: 'Horoscope',
                                child: TextField(
                                  controller: TextEditingController(
                                      text: (userState.userProfile!.birthday != null)
                                          ? getHoroscope(DateTime.parse(userState.userProfile!.birthday!))
                                          : formState.birthday != null
                                              ? getHoroscope(formState.birthday!)
                                              : '--'),
                                  cursorColor: Colors.white,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '--',
                                  ),
                                ),
                              ),

                              // Zodiac Field
                              _buildFormRow(
                                label: 'Zodiac',
                                child: TextField(
                                  controller: TextEditingController(
                                      text: (userState.userProfile!.birthday != null)
                                          ? getZodiac(DateTime.parse(userState.userProfile!.birthday!))
                                          : formState.birthday != null
                                              ? getZodiac(formState.birthday!)
                                              : '--'),
                                  cursorColor: Colors.white,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '--',
                                  ),
                                ),
                              ),

                              // Height Field
                              _buildFormRow(
                                label: 'Height (cm)',
                                child: FormBuilderTextField(
                                  name: 'height',
                                  initialValue: userState.userProfile?.height.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your height',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: 'Height is required'),
                                    FormBuilderValidators.numeric(errorText: 'Enter a valid number'),
                                    FormBuilderValidators.min(50, errorText: 'Height too short'),
                                    FormBuilderValidators.max(250, errorText: 'Height too tall'),
                                  ]),
                                  onChanged: (value) {
                                    final height = double.tryParse(value ?? '');
                                    if (height != null) {
                                      context.read<ProfileFormBloc>().add(UpdateHeight(height));
                                    }
                                  },
                                ),
                              ),

                              // Weight Field
                              _buildFormRow(
                                label: 'Weight (kg)',
                                child: FormBuilderTextField(
                                  initialValue: userState.userProfile?.weight.toString(),
                                  name: 'weight',
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your weight',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: 'Weight is required'),
                                    FormBuilderValidators.numeric(errorText: 'Enter a valid number'),
                                    FormBuilderValidators.min(20, errorText: 'Weight too low'),
                                    FormBuilderValidators.max(300, errorText: 'Weight too high'),
                                  ]),
                                  onChanged: (value) {
                                    final weight = double.tryParse(value ?? '');
                                    if (weight != null) {
                                      context.read<ProfileFormBloc>().add(UpdateWeight(weight));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
