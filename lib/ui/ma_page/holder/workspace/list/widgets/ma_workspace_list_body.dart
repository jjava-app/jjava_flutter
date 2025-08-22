import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/list/widgets/ma_workspace_list_button.dart';
import 'package:jjava_flutter/ui/vm/workspace_list_vm.dart';

class MaWorkspaceListBody extends ConsumerWidget {
  const MaWorkspaceListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // vm에서 리스트 받아와야 함 - ConsumerWidget
    // final items = WorkspaceListRepository.items;
    final model = ref.watch(workspaceListProvider);

    if (model == null) {
      return const SafeArea(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final items = model.sortedByCreatedDesc();
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          SizedBox(height: 8),
          MaWorkspaceListButton(),
          SizedBox(height: 24),
          MText.buttonM('내 기록', color: MColor.kLabel.neutral),
          SizedBox(height: 12),
          ...items!.map((e) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // debugPrint("open workspace ${e.id}");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => MaWorkspacePage()),
                    // );
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: MColor.kBackground.normal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MText.h5(
                            e.title,
                            color: MColor.kLabel.alternative,
                          ),
                        ),
                        SizedBox(width: 12),
                        MText.bodyTiny(e.createdAt, color: MColor.kLabel.assistive),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
