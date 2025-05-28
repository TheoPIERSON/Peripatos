import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<AppUser?>((ref) async* {
  final authService = ref.watch(authServiceProvider);
  
  // Initial check
  final currentUser = await authService.getCurrentUser();
  yield currentUser;
  
  // Listen for auth state changes
  yield* authService.authStateChanges.map((event) {
    if (event.session == null) return null;
    return AppUser.fromSupabaseUser(event.session!.user);
  });
});

final userProvider = FutureProvider<AppUser?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getCurrentUser();
});
