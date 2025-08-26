import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// Provider
final compileProvider = NotifierProvider<CompileFM, CompileModel>(() {
  return CompileFM();
});

// Form Model (Notifier)
class CompileFM extends Notifier<CompileModel> {
  @override
  CompileModel build() {
    return CompileModel("");
  }

  void payload(String payload) {
    state = state.copyWith(
      payload: payload,
    );

    Logger().d(payload);
  }
}

// Model
class CompileModel {
  String? payload;

  CompileModel(this.payload);

  Map<String, dynamic> toMap() {
    return {
      "payload": payload,
    };
  }

  CompileModel copyWith({
    String? payload,
  }) {
    return CompileModel(
      payload ?? this.payload,
    );
  }

  @override
  String toString() {
    return 'CompileModel{payload: $payload}';
  }
}
