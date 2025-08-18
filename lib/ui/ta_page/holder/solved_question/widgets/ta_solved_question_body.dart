import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_icon.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/repository/solved_question_repository.dart';

class TaSolvedQuestionBody extends StatefulWidget {
  TaSolvedQuestionBody({super.key});

  @override
  State<TaSolvedQuestionBody> createState() => _MaSolvedQuestionBodyState();
}

class _MaSolvedQuestionBodyState extends State<TaSolvedQuestionBody> {
  int? expandedId;

  @override
  Widget build(BuildContext context) {
    final array = SolvedQuestionRepository.listArray;
    final string = SolvedQuestionRepository.listString;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), //
        children: [
          MText.h7('리스트(배열)'),
          SizedBox(height: 12),
          ...array.map((e) {
            final opened = expandedId == e.id;
            return _buildItemCard(e, opened);
          }),
          SizedBox(height: 20),
          MText.h7('문자열'),
          SizedBox(height: 12),
          ...string.map((e) {
            final opened = expandedId == e.id;
            return _buildItemCard(e, opened);
          }),
        ],
      ),
    );
  }

  Widget _buildItemCard(SolvedQuestionItem e, bool opened) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 180),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: opened ? Color(0xFFF0F8F4) : MColor.kLabel.white, // 전체 배경
        borderRadius: BorderRadius.circular(12),
        border: opened
            ? Border.all(color: MColor.kPrimary.normal, width: 1)
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() {
          expandedId = opened ? null : e.id;
        }),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목 Row
              Row(
                children: [
                  Expanded(
                    child: MText.h5(
                      e.title,
                      color: opened
                          ? MColor.kPrimary.normal
                          : MColor.kLabel.alternative,
                    ),
                  ),
                ],
              ),

              // 펼쳤을 때 내용
              ClipRect(
                child: AnimatedAlign(
                  duration: Duration(milliseconds: 180),
                  alignment: Alignment.topCenter,
                  heightFactor: opened ? 1.0 : 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      MText.bodyXXS(e.date, color: MColor.kLabel.neutral),
                      SizedBox(height: 12),

                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(0xFFEAEAEA),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: 4),
                          MText.h5('문제'),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        e.prompt,
                        style: TextStyle(fontSize: 13, height: 1.4),
                      ),
                      SizedBox(height: 14),

                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(0xFFEAEAEA),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: 6),
                          MText.s16Bold('AI 첨삭', color: MColor.kButton.active),
                        ],
                      ),
                      SizedBox(height: 6),
                      MText.modal3(e.aiReview, color: MColor.kLabel.normal),
                      SizedBox(height: 16),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF333B4A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MText.modal3('java', color: Colors.white),
                                Spacer(),
                                MIcon.page.solvedQuestion.copy,
                              ],
                            ),
                            SizedBox(height: 12),
                            MText.modal3(
                              e.codeSample,
                              color: MColor.kLabel.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
