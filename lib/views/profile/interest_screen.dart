import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';
import 'package:test/widgets/appbar_back_button.dart';
import 'package:test/widgets/gradient_background.dart';
import 'package:test/widgets/gradient_componentdart';
import 'package:test/widgets/tag.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> initialTags = [];
  late List<String> _tags;
  final TextEditingController _tagInputController = TextEditingController();
  bool _isEditing = false;

  void _addTag(String tag) {
    if (tag.trim().isNotEmpty && !_tags.contains(tag.trim())) {
      setState(() {
        _tags.add(tag.trim());
        _isEditing = false;
        _tagInputController.clear();
      });
      // TODO: sync the local tags with the bloc, so that it can be saved
      // widget.onTagsUpdated(_tags);
    }
  }

  @override
  void initState() {
    super.initState();
    _tags = List.from(initialTags);
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const AppbarBackButton(),
          actions: [TextButton(onPressed: () {}, child: const GradientText('Save', colors: ColorApp.blueGradientColorList))],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const GradientText(
                'Tell everyone about yourself',
                colors: ColorApp.goldenGradientColorList,
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Text('What interest you?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => setState(() {
                  _isEditing = true;
                  _tagInputController.clear();
                }),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: ColorApp.emptyBackgroundLight),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ..._tags.map((tag) => Tag(text: tag)),
                      if (_isEditing)
                        IntrinsicWidth(
                          child: TextField(
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            controller: _tagInputController,
                            autofocus: true,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                  onPressed: () => setState(() {
                                        _isEditing = false;
                                      }),
                                  icon: const Icon(CupertinoIcons.clear, color: Colors.white70, size: 14)),
                              contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              isDense: true,
                              isCollapsed: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onSubmitted: _addTag,
                          ),
                        )
                      else
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isEditing = true;
                              _tagInputController.clear();
                            });
                          },
                          child: const Tag(text: "+"),
                        ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
