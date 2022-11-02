// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final watchAuthStateProvider = StreamProvider(
    (ref) => ref.watch(firebaseAuthRepositoryProvider).onAuthStateChanged);
