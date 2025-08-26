import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
);

Future<Map<String, String>?> handleGoogleSignIn() async {
  try {
    final account = await googleSignIn.signIn();
    if (account == null) return null; // 로그인 취소 시 null

    final auth = await account.authentication;

    // 토큰값 반환
    return {
      'idToken': auth.idToken ?? '',
      'accessToken': auth.accessToken ?? '',
      'displayName': account.displayName ?? '',
      'email': account.email,
    };
  } catch (error) {
    print('Sign in failed: $error');
    return null;
  }
}
