import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_leave_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_restart_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/widget/dialog/ma_save_dialog.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_body.dart';

class MaWorkspacePage extends StatefulWidget {
  final int workspaceId;

  const MaWorkspacePage({
    super.key,
    required this.workspaceId,
  });

  @override
  State<MaWorkspacePage> createState() => _MaWorkspacePageState();
}

class _MaWorkspacePageState extends State<MaWorkspacePage> {
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
    // TODO: 종료 클릭 시 서버에 저장하고 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MaWorkspacePage(workspaceId: widget.workspaceId),
      ),
    );
  }

  // 다시 시작 다이얼로그
  Future<void> _onRestartTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x99000000),
      builder: (_) => MaRestartDialog(
        title: '다시 시작',
        message: '문제를 다시 시작하시겠습니까?',
        cancelText: '취소',
        confirmText: '다시 시작',
      ),
    );
    if (confirmed != true || !mounted) return;
    // TODO: 다시 시작 클릭 시 대시보드 초기화 지금은 임시로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MaWorkspacePage()),
    );
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MaWorkspacePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: MaWorkspaceBody(),
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
                  style: TextStyle(fontSize: 14, color: MColor.kStatus.destructive),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
