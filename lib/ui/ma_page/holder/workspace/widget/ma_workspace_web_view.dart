import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/widget/ma_workspace_block_dashboard.dart';

class MaWorkspaceWebView extends StatefulWidget {
  final ValueChanged<bool> onLoading;

  const MaWorkspaceWebView({
    super.key,
    required this.onLoading,
  });

  @override
  State<MaWorkspaceWebView> createState() => _MaWorkspaceWebViewState();
}

class _MaWorkspaceWebViewState extends State<MaWorkspaceWebView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: MaWorkspaceBlockDashboard()),
          ],
        ),
        // 실행 버튼
        Positioned(
          top: 8,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0x29FF6969),
            ),
            child: InkWell(
              // TODO: 클릭 시 통신
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      '실행',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF6969),
                      ),
                    ),
                    MIcon.page.question.polygon,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
