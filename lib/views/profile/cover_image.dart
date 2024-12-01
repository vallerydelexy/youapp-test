import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/services/bloc/user_bloc.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/helper.dart';
import 'package:test/widgets/tag.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({super.key});

  int getAge(String birthday) {
    DateTime now = DateTime.now();
    DateTime birthDate = DateTime.parse(birthday);
    int age = now.year - birthDate.year;
    int month1 = now.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = now.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserProfileState>(
      builder: (context, userState) {
        debugPrint('cover image build ${userState.userProfile?.image}');

        return SizedBox(
          height: 190,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorApp.emptyBackgroundDark),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (userState.userProfile?.image != null)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        const Base64Decoder().convert(userState.userProfile!.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (userState.userProfile != null)
                        Text(
                          '${userState.userProfile?.name}, ${getAge(userState.userProfile!.birthday!)}',
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4), 
                        if (userState.userProfile != null)
                         Row(
                          children: [
                            Tag(text: getHoroscope(DateTime.parse(userState.userProfile!.birthday!))),
                            const SizedBox(width: 8),
                            Tag(text: getZodiac(DateTime.parse(userState.userProfile!.birthday!))),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
