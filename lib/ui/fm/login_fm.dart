import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = NotifierProvider<LoginFM, LoginModel>(() {
  return LoginFM();
});

class LoginFM extends Notifier<LoginModel> {
  @override
  LoginModel build() {
    return LoginModel("", "");
  }

  void email(String email) {
    state = state.copyWith(
      email: email,
    );
  }

  void password(String password) {
    state = state.copyWith(
      password: password,
    );
  }
}

class LoginModel {
  String? email;
  String? password;

  LoginModel(
    this.email,
    this.password,
  );

  Map<String, dynamic> toMap() {
    return {"email": email, "password": password};
  }

  LoginModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginModel(
      email ?? this.email,
      password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'LoginModel{email: $email, password: $password}';
  }
}
