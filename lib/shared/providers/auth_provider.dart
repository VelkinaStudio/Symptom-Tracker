import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/drive.appdata'],
  );
});

final googleAccountProvider = StateProvider<GoogleSignInAccount?>((ref) => null);

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(googleAccountProvider) != null;
});
