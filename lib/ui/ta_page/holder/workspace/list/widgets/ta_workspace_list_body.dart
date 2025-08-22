import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/repository/workspace_list_repository.dart';
import 'package:jjava_flutter/ui/ta_page/holder/workspace/list/widgets/ta_workspace_list_button.dart';

class TaWorkspaceListBody extends StatelessWidget {
  const TaWorkspaceListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final items = WorkspaceListRepository.items;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          SizedBox(height: 8),
          TaWorkspaceListButton(),
          SizedBox(height: 24),
          MText.buttonM('내 기록', color: MColor.kLabel.neutral),
          SizedBox(height: 12),
          ...items.map((e) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => debugPrint("open workspace ${e.id}"),
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
                        MText.bodyTiny(e.date, color: MColor.kLabel.assistive),
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
