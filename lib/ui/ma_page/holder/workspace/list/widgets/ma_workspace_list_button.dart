import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/vm/workspace_list_vm.dart';
import 'package:logger/logger.dart';

class MaWorkspaceListButton extends ConsumerWidget {
  const MaWorkspaceListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        Logger().d("생성된다~~");
        await ref.read(workspaceListProvider.notifier).create();
      },
      child: Ink(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF32C36C), width: 1.2),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MText.buttonM('블록코딩 만들기', color: MColor.kLabel.alternative),
              SizedBox(height: 8),
              MIcon.page.workspace.plusSquare(
                size: 20,
                color: MColor.kLabel.alternative,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
