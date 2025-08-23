import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/ui/ma_page/holder/workspace/ma_workspace_page.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/list/widgets/ta_workspace_list_button.dart';
import 'package:jjava_flutter/ui/vm/workspace_list_vm.dart';

class TaWorkspaceListBody extends ConsumerWidget {
  const TaWorkspaceListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(workspaceListProvider);

    if (model == null) {
      return const SafeArea(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final items = model.sortedByCreatedDesc();
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const SizedBox(height: 8),
          const TaWorkspaceListButton(),
          const SizedBox(height: 24),
          MText.buttonM('내 기록', color: MColor.kLabel.neutral),
          const SizedBox(height: 12),
          ...items.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    debugPrint("open workspace ${e.id}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MaWorkspacePage(workspaceId: e.id),
                      ),
                    );
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
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
                        const SizedBox(width: 12),
                        MText.bodyTiny(
                          e.createdAt,
                          color: MColor.kLabel.assistive,
                        ),
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
