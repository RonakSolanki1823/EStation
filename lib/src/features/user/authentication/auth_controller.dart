import 'auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final AuthService _authService;

  AuthController(this._authService);

  /// 🔹 Sign up a new user
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final userMetadata = {
        'full_name': name,
        'phone_number': phone,
      };

      final user = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        userMetadata: userMetadata,
      );

      if (user != null) {
        await _authService.addUserToPublicTable(
          userId: user.id,
          email: user.email!,
          name: name,
          phone: phone,
        );
      }

      return user;
    } catch (e) {
      // Propagate the error to UI
      throw Exception(e.toString());
    }
  }

  /// 🔹 Sign in
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 🔹 Sign out
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 🔹 Get user type by email
  Future<String?> getUserTypeByEmail(String email) async {
    return await _authService.getUserType(email);
  }

  /// 🔹 Get user name by user ID
  Future<String?> getUserName(String userId) async {
    return await _authService.getUserName(userId);
  }
}
