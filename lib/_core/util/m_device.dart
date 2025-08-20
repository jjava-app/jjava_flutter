import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

/// AccessToken
// AccessToken 저장
Future<void> saveAccessToken(String? accessToken) async {
  await secureStorage.write(key: "accessToken", value: accessToken);
}

// AccessToken 조회
Future<String?> getAccessToken() async {
  return await secureStorage.read(key: "accessToken");
}

// AccessToken 삭제
Future<void> deleteAccessToken() async {
  await secureStorage.delete(key: "accessToken");
}

/// FCM Token
// FcmToken 저장
Future<void> saveFcmToken(String? fcmToken) async {
  await secureStorage.write(key: "fcmToken", value: fcmToken);
}

// FcmToken 조회
Future<String?> getFcmToken() async {
  return await secureStorage.read(key: "fcmToken");
}

// FcmToken 삭제
Future<void> deleteFcmToken() async {
  await secureStorage.delete(key: "fcmToken");
}
