import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/services/bloc/user_bloc.dart';
import 'package:test/utils/preferences.dart';
import 'package:test/views/profile/about_section.dart';
import 'package:test/views/profile/cover_image.dart';
import 'package:test/views/profile/interest_section.dart';
import 'package:test/widgets/appbar_back_button.dart';
import 'package:test/widgets/dark_background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkBackground(

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const AppbarBackButton(),
            actions: [
              PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                menuPadding: const EdgeInsets.all(0),
                icon: const Icon(Icons.more_horiz, color: Colors.white),
                onSelected: (value) {
                  if (value == 'logout') {
                    Preferences.setAccessToken('');
                    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text('Log Out'),
                      ),
                    ),
                  ];
                },
              ),
            ],
            title: BlocBuilder<UserBloc, UserProfileState>(
              builder: (context, userState) {
                return Text(userState.userProfile?.name ?? "@username", style: const TextStyle(color: Colors.white, fontSize: 17));
              },
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async => context.read<UserBloc>().add(GetUserProfileEvent()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: const [CoverImage(), SizedBox(height: 20), AboutSection(), SizedBox(height: 20), InterestSection()],
              ),
            ),
          ),
        ),
    );
  }
}
