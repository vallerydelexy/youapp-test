import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/services/bloc/user_bloc.dart';
import 'package:test/widgets/editable_section.dart';
import 'package:test/widgets/tag.dart';

class InterestSection extends StatelessWidget {
  const InterestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserProfileState>(
      builder: (context, userState) {
        return EditableSection(title: "Interests", editButtonCallback: () => Navigator.pushNamed(context, '/about/interest'), children: [
          (userState.userProfile != null && userState.userProfile!.interests!.isNotEmpty)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [...?userState.userProfile?.interests!.map((tag) => Tag(text: tag))],
                  ),
              )
              : Align(
                  alignment: Alignment.center,
                  child: Text("Add in your interest to find a better match",
                      style: TextStyle(color: Colors.white.withOpacity(0.33), fontSize: 14)),
                ),
        ]);
      },
    );
  }
}
