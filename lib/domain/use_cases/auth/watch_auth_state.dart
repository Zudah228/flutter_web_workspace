// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final watchAuthStateProvider = StreamProvider(
    (ref) => ref.watch(firebaseAuthRepositoryProvider).onAuthStateChanged,);
