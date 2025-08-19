import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';

class MaRestartDialog extends StatelessWidget {
  const MaRestartDialog({
    required this.title,
    required this.message,
    this.cancelText = '취소',
    this.confirmText = '다시 시작',
  });

  final String title;
  final String message;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MColor.kBackground.normal,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MColor.kLabel.normal,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MColor.kLabel.neutral,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: MColor.kLine.normal),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        fontSize: 16,
                        color: MColor.kLabel.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: MColor.kLine.normal),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MColor.kStatus.destructive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
