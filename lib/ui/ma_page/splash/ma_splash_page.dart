import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/data/gvm/session_gvm.dart';

class MaSplashPage extends ConsumerStatefulWidget {
  const MaSplashPage({super.key});

  @override
  ConsumerState<MaSplashPage> createState() => _MaSplashPageState();
}

class _MaSplashPageState extends ConsumerState<MaSplashPage> {
  bool _loading = false;

  Future<void> _goMainWithProviderToken() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      // 소셜 액세스 토큰 → 서버 로그인 → GVM이 저장/헤더세팅/화면이동
      const providerToken =
          'AAAAN28KP6s5arfj6jkCPZqZb3mxK_mjKCwvkGKVKPj78BDvTPLOVN-DQqDNH2fGcwVi9p7CsqaBiMjCqfmBLY8cDJ8';
      await ref
          .read(sessionProvider.notifier)
          .oauthLogin(
            provider: 'naver', // kakao / google 로 바꿀 수 있음
            providerToken: providerToken,
          );
      // SessionGVM 내부에서 Navigator.pushNamed(ctx, '/main-holder') 실행됨
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/animation/splash.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            child: Text('로그인\n페이지'),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn2',
            child: Text('메인\n페이지'),
            onPressed: () async {
              if (_loading) return;
              await _goMainWithProviderToken(); // ← 괄호!
            },
          ),
        ],
      ),
    );
  }
}
