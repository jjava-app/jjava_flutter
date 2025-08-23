import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ta_page/holder/ta_main_holder.dart';
import 'package:jjava_flutter/ui/ta_page/holder/widget/dialog/ta_leave_dialog.dart';
import 'package:jjava_flutter/ui/ta_page/holder/widget/dialog/ta_restart_dialog.dart';
import 'package:jjava_flutter/ui/ta_page/holder/widget/dialog/ta_save_dialog.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_block_dashboard.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/widget/ta_workspace_body.dart';
import 'package:jjava_flutter/ui/vm/workspace_vm.dart';

class TaWorkspacePage extends ConsumerStatefulWidget {
  final int workspaceId;

  const TaWorkspacePage({super.key, required this.workspaceId});

  @override
  ConsumerState<TaWorkspacePage> createState() => _TaWorkspacePageState();
}

class _TaWorkspacePageState extends ConsumerState<TaWorkspacePage> {
  final dashboardKey = GlobalKey<TaWorkspaceBlockDashboardState>();

  Future<void> _onFinishTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => TaLeaveDialog(
        title: '학습 종료',
        message: '학습을 종료하시겠습니까?',
        cancelText: '취소',
        confirmText: '종료',
      ),
    );
    if (confirmed != true || !mounted) return;

    await dashboardKey.currentState?.exportWorkspaceJson();
    final updateModel = ref.read(workspaceUpdateProvider);

    try {
      await ref
          .read(workspaceProvider(widget.workspaceId).notifier)
          .update(
            widget.workspaceId,
            updateModel.title,
            updateModel.serializedJson,
            updateModel.libraryJson,
          );
    } catch (e, s) {
      Logger().e("저장 실패", error: e, stackTrace: s);
    }

    Navigator.pop(context); // 리스트로 이동
  }

  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => TaRestartDialog(
        title: '다시 시작',
        message: '문제를 다시 시작하시겠습니까?',
        cancelText: '취소',
        confirmText: '다시 시작',
      ),
    );

    if (confirmed != true || !mounted) return;

    await dashboardKey.currentState?.resetWorkspace();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("워크스페이스가 초기화되었습니다")),
      );
    }
  }

  Future<void> _onSaveTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => TaSaveDialog(
        title: '만들기 저장',
        message: '만들기를 저장하시겠습니까?',
        cancelText: '취소',
        confirmText: '저장',
      ),
    );
    if (confirmed != true || !mounted) return;

    await dashboardKey.currentState?.exportWorkspaceJson();
    final updateModel = ref.read(workspaceUpdateProvider);

    await ref
        .read(workspaceProvider(widget.workspaceId).notifier)
        .update(
          widget.workspaceId,
          updateModel.title,
          updateModel.serializedJson,
          updateModel.libraryJson,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("저장 완료")),
      );
    }
  }

  Future<void> _onDeleteTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x99000000),
      builder: (_) => AlertDialog(
        title: const Text("삭제"),
        content: const Text("이 워크스페이스를 삭제하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("삭제", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref
        .read(workspaceProvider(widget.workspaceId).notifier)
        .delete(widget.workspaceId);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final workspace = ref.watch(workspaceProvider(widget.workspaceId));

    if (workspace == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: _appbar(),
      body: TaWorkspaceBody(
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
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: MColor.kLabel.neutral,
          ),
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
            hintText: '타이틀 입력',
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          onChanged: (value) {
            ref.read(workspaceUpdateProvider.notifier).title(value);
          },
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: MIcon.page.global.more,
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
            const PopupMenuItem(
              value: 'save',
              child: Center(child: Text('저장')),
            ),
            const PopupMenuItem(
              value: 'restart',
              child: Center(child: Text('다시 시작')),
            ),
            const PopupMenuItem(
              value: 'finish',
              child: Center(child: Text('만들기 종료')),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Center(child: Text('삭제')),
            ),
          ],
        ),
      ],
    );
  }
}
