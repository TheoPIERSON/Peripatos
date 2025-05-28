import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<AppUser?> getCurrentUser() async {
    final user = supabase.auth.currentUser;
    return user != null ? AppUser.fromSupabaseUser(user) : null;
  }

  Future<AppUser?> signInWithEmail(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response.user != null
        ? AppUser.fromSupabaseUser(response.user!)
        : null;
  }

  Future<AppUser?> signUpWithEmail(String email, String password) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    return response.user != null
        ? AppUser.fromSupabaseUser(response.user!)
        : null;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> updateProfile({
    String? name,
    String? avatarUrl,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.auth.updateUser(
      UserAttributes(
        data: {
          if (name != null) 'name': name,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
        },
      ),
    );
  }

  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
}
