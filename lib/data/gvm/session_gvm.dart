// session_provider.dart (핵심만 발췌)
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jjava_flutter/main.dart' show navigatorKey;

const _baseUrl = 'http://10.0.2.2:8080';

final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(SessionGVM.new);

class SessionGVM extends Notifier<SessionModel> {
  final _storage = const FlutterSecureStorage();
  late final Dio _noAuth; // 로그인 교환
  late final Dio _auth; // 인증 API

  Dio get auth => _auth;

  @override
  SessionModel build() {
    _noAuth = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    _auth = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    return SessionModel();
  }

  Future<void> oauthLogin({
    required String provider, // 'kakao' | 'naver' | 'google'
    required String providerToken,
  }) async {
    final ctx = navigatorKey.currentContext!;

    // 네트워크 로그 (원하면 주석 해제)
    _noAuth.interceptors.clear();
    _noAuth.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );

    final res = await _noAuth.post(
      '/login/$provider',
      data: {
        'accessToken': providerToken.trim(), // 앞뒤 공백 제거
      },
      // 500이어도 예외 던지지 말고 바디 확인
      options: Options(validateStatus: (_) => true),
    );

    debugPrint('LOGIN status=${res.statusCode}');
    debugPrint('LOGIN body=${res.data}');

    if (res.statusCode != 200 || res.data == null || res.data['status'] != 200) {
      final msg = (res.data is Map) ? (res.data['msg'] ?? '서버 오류') : '서버 오류';
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('로그인 실패: $msg')));
      return;
    }

    final body = res.data['body'] as Map<String, dynamic>;
    var jwt = (body['accessToken'] as String).trim();
    if (jwt.startsWith('Bearer ')) jwt = jwt.substring(7);

    await _storage.write(key: 'access_token', value: jwt);
    _setAuthHeader(jwt);

    final user = User.fromLoginUser(body['user'] as Map<String, dynamic>);
    state = SessionModel(user: user, isLogin: true);

    Navigator.pushNamed(ctx, '/main-holder');
  }

  Future<void> useExternalJwt(String jwt) async {
    final ctx = navigatorKey.currentContext!;
    await _storage.write(key: 'access_token', value: jwt);
    _setAuthHeader(jwt);
    final me = await fetchMe();
    state = SessionModel(user: User.fromMeBody(me), isLogin: true);
    Navigator.pushNamed(ctx, '/main-holder');
  }

  Future<void> tryAutoLogin() async {
    final jwt = await _storage.read(key: 'access_token');
    if (jwt == null || jwt.isEmpty) return;
    _setAuthHeader(jwt);
    final me = await fetchMe();
    state = SessionModel(user: User.fromMeBody(me), isLogin: true);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    state = SessionModel();
    _auth.options.headers.remove('Authorization');
    final ctx = navigatorKey.currentContext!;
    Navigator.pushNamedAndRemoveUntil(ctx, '/login', (_) => false);
  }

  // === helpers ===
  void _setAuthHeader(String jwt) {
    _auth.options.headers['Authorization'] = 'Bearer $jwt';
  }

  Future<Map<String, dynamic>> fetchMe() async {
    final res = await _auth.get('/users/mypage');
    final map = res.data as Map<String, dynamic>;
    if (map['status'] != 200 || map['body'] == null) {
      throw Exception(map['msg'] ?? '프로필 조회 실패');
    }
    return Map<String, dynamic>.from(map['body'] as Map);
  }
}

// 아래 User/SessionModel은 이전 답변 그대로 사용
class SessionModel {
  final User? user;
  final bool isLogin;

  SessionModel({this.user, this.isLogin = false});
}

class User {
  final int id;
  final String email;
  final String username;
  final String role;
  final String? level;
  final int? score;
  final int? rank;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    this.level,
    this.score,
    this.rank,
  });

  factory User.fromLoginUser(Map<String, dynamic> j) => User(
    id: j['id'],
    email: j['email'],
    username: j['username'],
    role: j['role'],
  );

  factory User.fromMeBody(Map<String, dynamic> j) => User(
    id: j['id'],
    email: j['email'],
    username: j['username'],
    role: (j['role'] as String?) ?? 'USER',
    level: j['level'] as String?,
    score: j['score'] as int?,
    rank: j['rank'] as int?,
  );
}
