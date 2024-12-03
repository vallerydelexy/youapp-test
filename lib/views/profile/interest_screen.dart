import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/models/user_model.dart';
import 'package:test/services/api/user_api.dart';
import 'package:test/services/bloc/profile_form_bloc.dart';
import 'package:test/services/bloc/user_bloc.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/preferences.dart';
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
  // List<String> initialTags = [];
  List<String> _tags = [];
  final TextEditingController _tagInputController = TextEditingController();
  bool _isEditing = false;
  final profileFormBloc = ProfileFormBloc(UserApi());

  Future<UserModel?> getLocalUserProfile() async {
    Map<String, dynamic> sharedPreferencesProfile = await Preferences.getProfile();
    if (sharedPreferencesProfile.isNotEmpty) {
      final fromSharedPreferences = UserModel.fromJson(sharedPreferencesProfile);
      return fromSharedPreferences;
    } else {
      return null;
    }
  }

  void _addTag(String tag) {
    if (tag.trim().isNotEmpty && !_tags.contains(tag.trim())) {
      setState(() {
        _tags.add(tag.trim());
        _isEditing = false;
        _tagInputController.clear();
      });
      profileFormBloc.add(UpdateInterest(_tags));
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    profileFormBloc.add(UpdateInterest(_tags));
  }

  void saveInterest(BuildContext context) {
    profileFormBloc.add(SubmitForm());
    Navigator.pop(context);
    UserBloc(userApi: UserApi()).add(GetUserProfileEvent());
  }

  @override
  void dispose() {
    _tagInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
      getLocalUserProfile().then((value) {
        debugPrint('value: ${value?.interests}');
        setState(() {
          _tags = List.from(value?.interests as Iterable<String>);
        });
      });
      
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isEditing = false;
            _tagInputController.clear();
          });
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const AppbarBackButton(),
            actions: [
              TextButton(onPressed: () => saveInterest(context), child: const GradientText('Save', colors: ColorApp.blueGradientColorList))
            ],
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
                        ..._tags.map(
                          (tag) => Tag(
                            text: tag,
                            trailing: InkWell(
                              onTap: () => _removeTag(tag),
                              child: const Icon(CupertinoIcons.clear, color: Colors.white70, size: 14),
                            ),
                          ),
                        ),
                        if (_isEditing)
                          IntrinsicWidth(
                            child: TextField(
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              controller: _tagInputController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Enter your interest',
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
      ),
    );
  }
}
