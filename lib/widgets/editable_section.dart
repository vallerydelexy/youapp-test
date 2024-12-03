import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';

import 'package:test/widgets/svg_icon.dart';

class EditableSection extends StatelessWidget {
  const EditableSection({super.key, required this.children, required this.title, required this.editButtonCallback});
  final Function editButtonCallback;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorApp.emptyTextAreaBackgroundDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                         Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => editButtonCallback(),
                            icon: const SvgIcon('edit', width: 17, height: 17, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    ...children
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
