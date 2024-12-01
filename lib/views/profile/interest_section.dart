import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';
import 'package:test/widgets/svg_icon.dart';

class InterestSection extends StatelessWidget {
  const InterestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorApp.emptyTextAreaBackgroundDark),
          child: Stack(fit: StackFit.expand, children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text("Interests", style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/about/interest'),
                icon: const SvgIcon('edit', width: 17, height: 17, color: Colors.white),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text("Add in your interest to find a better match",
                    style: TextStyle(color: Colors.white.withOpacity(0.33), fontSize: 14))),
          ]),
        )
        //(child: const Text("Interests", style: TextStyle(color: Colors.white, fontSize: 14)))),
        );
  }
}

// 