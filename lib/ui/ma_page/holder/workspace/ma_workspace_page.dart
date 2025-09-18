import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/fm/workspace_fm.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_delete_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_leave_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_restart_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_save_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/list/ma_workspace_list_page.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_body.dart';
import 'package:jjava_flutter/ui/vm/solved_question_vm.dart';
import 'package:logger/logger.dart';

import '../../../vm/workspace_vm.dart';

class MaWorkspacePage extends ConsumerStatefulWidget {
  final int workspaceId;

  const MaWorkspacePage({
    super.key,
    required this.workspaceId,
  });

  @override
  ConsumerState<MaWorkspacePage> createState() => _MaWorkspacePageState();
}

class _MaWorkspacePageState extends ConsumerState<MaWorkspacePage> {
  final dashboardKey = GlobalKey<MaWorkspaceBlockDashboardState>();

  // TODO: 통신 시 실행 로직들 분리하여 vm에 옮기기

  // 만들기 종료 다이얼로그 로직
  Future<void> _onFinishTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaLeaveDialog(
        title: '학습 종료',
        message: '학습을 종료하시겠습니까?',
        cancelText: '취소',
        confirmText: '종료',
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(solvedQuestionListProvider.notifier).init();

    // 4. 저장 끝났으면 이ㅗㅇ
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MaWorkspaceListPage()), // <- 이동할 화면
      (route) => false, // 스택 다 지우고 새 화면만 남김
    );
  }

  // 다시 시작 다이얼로그
  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => MaRestartDialog(
        title: '다시 시작',
        message: '문제를 다시 시작하시겠습니까?',
        cancelText: '취소',
        confirmText: '다시 시작',
      ),
    );

    if (confirmed != true || !mounted) return;

    // ✅ 블록만 초기화 (서버 저장 X)
    await dashboardKey.currentState?.resetWorkspace();

    // ✅ 알림 메시지
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("워크스페이스가 초기화되었습니다")),
      );
    }
  }

  // 저장 다이얼로그
  Future<void> _onSaveTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaSaveDialog(
        title: '만들기 저장',
        message: '만들기를 저장하시겠습니까?',
        cancelText: '취소',
        confirmText: '저장',
      ),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 다시 시작 클릭 시 대시보드 초기화 지금은 임시로 이동
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => MaWorkspacePage()),
    // );
    //1. 블록 JSON 추출 → workspaceUpdateProvider에 반영됨
    await dashboardKey.currentState?.exportWorkspaceJson();

    //2. provider에 모인 값 읽기
    final updateModel = ref.read(workspaceUpdateProvider);

    // 값 확인 로그
    Logger().d("REQ BODY => ${updateModel.toMap()}");

    //3. 서버에 저장 요청
    await ref
        .read(workspaceProvider(widget.workspaceId).notifier)
        .update(
          widget.workspaceId,
          updateModel.title,
          updateModel.serializedJson,
          updateModel.libraryJson,
        );
    //4. 저장 완료 메시지
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("저장 완료")),
    );
  }

  Future<void> _onDeleteTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => const MaDeleteDialog(
        title: "삭제",
        message: "이 워크스페이스를 삭제하시겠습니까?",
        cancelText: "취소",
        confirmText: "삭제",
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(workspaceProvider(widget.workspaceId).notifier).delete(widget.workspaceId);

      if (!mounted) return;
      Navigator.pop(context); // 삭제 후 리스트 페이지 이동
    } catch (e, s) {
      Logger().e("삭제 실패", error: e, stackTrace: s);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("삭제 실패")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final workspace = ref.watch(workspaceProvider(widget.workspaceId));

    if (workspace == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: _appbar(),
      body: MaWorkspaceBody(
        workspaceId: workspace.id,
        dashboardKey: dashboardKey,
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        height: 49,
        child: TextFormField(
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: MColor.kLabel.neutral,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: '타이틀 입력',
            hintStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: MColor.kLabel.disable,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            ref.read(workspaceUpdateProvider.notifier).title(value);
          },
        ),
      ),
      leadingWidth: 90,
      actions: [
        PopupMenuButton<String>(
          icon: MIcon.page.global.more,
          position: PopupMenuPosition.under,
          offset: Offset(-16, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 8,
          color: MColor.kBackground.normal,
          onSelected: (value) async {
            if (value == 'restart') {
              await _onRestartTap();
            } else if (value == 'finish') {
              await _onFinishTap();
            } else if (value == 'save') {
              await _onSaveTap();
            } else if (value == 'delete') {
              await _onDeleteTap();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'save',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '저장',
                  style: TextStyle(fontSize: 14, color: MColor.kLabel.normal),
                ),
              ),
            ),
            PopupMenuItem(
              value: 'restart',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '다시 시작',
                  style: TextStyle(fontSize: 14, color: MColor.kLabel.normal),
                ),
              ),
            ),
            PopupMenuItem(
              value: 'finish',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '만들기 종료',
                  style: TextStyle(
                    fontSize: 14,
                    color: MColor.kStatus.destructive,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(
                  '삭제',
                  style: TextStyle(
                    fontSize: 14,
                    color: MColor.kStatus.destructive,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
