// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../domain/use_cases/index.dart';
import '../../widgets/profile_display.dart';
import '../setting/setting_page.dart';

class MyPage extends ConsumerWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const padding = EdgeInsets.symmetric(
      horizontal: 48,
    );

    final profile = ref.watch(userProfileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              SettingPage.push(context);
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: padding,
              child: ProfileDisplay(
                profile: profile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
