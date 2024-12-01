import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';
import 'package:test/widgets/appbar_back_button.dart';
import 'package:test/widgets/gradient_background.dart';
import 'package:test/widgets/gradient_componentdart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GradientBackground(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const AppbarBackButton()),
        backgroundColor: Colors.transparent,
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GradientText('Tell everyone about yourself', colors: ColorApp.goldenGradientColorList)
              ]
            ),
          )
        ),
      ),
    );
  }
}
