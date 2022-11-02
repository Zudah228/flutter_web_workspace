// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import '../../../domain/use_cases/index.dart';
import '../../../domain/use_cases/user_profile/save_user_profile.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/thumbnail.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditProfilePage()),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  Uint8List? imageFile;

  final nameFormKey = GlobalKey<FormFieldState>();
  final imagePicker = ImagePicker();
  late final currentProfile = ref.watch(userProfileControllerProvider);
  late final saveUserProfile = ref.watch(saveUserProfileProvider);

  @override
  Widget build(
    BuildContext context,
  ) {
    Future<void> pickImage() async {
      final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        return;
      }
      imageFile = await xFile.readAsBytes();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleThumbnail(
                    size: 160,
                    url: currentProfile?.imageUrl,
                    file: imageFile,
                    onTap: pickImage,
                  ),
                  Positioned.fill(
                    child: ClipOval(
                      child: InkWell(
                        onTap: pickImage,
                        child: ColoredBox(
                          color: Colors.black.withOpacity(0.3),
                          child: Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 72,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                key: nameFormKey,
                initialValue: currentProfile?.name,
                validator: (value) {
                  if (value == null) {
                    return '必須です';
                  }
                  if (value.isEmpty) {
                    return '必須です';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              // ? const CircleLoadingIndicator()
              SubmitButton(
                onPressed: () {
                  saveUserProfile
                      .update(
                        imageFile: imageFile,
                        name: nameFormKey.currentState?.value ?? '',
                      )
                      .then((_) => Navigator.of(context).pop());
                },
                child: const Text('保存'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
