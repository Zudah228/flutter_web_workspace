// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../common/index.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../pages/edit_profile/edit_profile_page.dart';
import 'thumbnail.dart';

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({Key? key, required this.profile}) : super(key: key);
  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleThumbnail(
          size: 130,
          url: profile?.imageUrl,
        ),
        const SizedBox(
          height: 36,
        ),
        Text(
          profile?.name ?? '設定されていません',
          style: context.titleStyle,
        ),
        TextButton(
          onPressed: (() {
            EditProfilePage.push(context);
          }),
          child: const Text(
            '編集',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text('登録した本の数： ${profile?.bookCount ?? '0'}'),
        const SizedBox(
          height: 36,
        ),
      ],
    );
  }
}
