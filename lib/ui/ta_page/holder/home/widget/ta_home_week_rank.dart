import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jjava_flutter/_core/style/m_color.dart';
import 'package:jjava_flutter/_core/style/m_text.dart';
import 'package:jjava_flutter/data/repository/home_repository.dart';

class TaHomeWeekRank extends StatelessWidget {
  const TaHomeWeekRank({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepository = HomeRepository();
    final response = await homeRepository.getHome();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText.h2("이번 주 랭킹", color: MColor.kLabel.neutral),
          const SizedBox(height: 8),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(color: MColor.kLine.normal),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 22,
                top: 12,
                right: 22,
                bottom: 12,
              ),
              child: SizedBox(
                height: 30,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 30,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    scrollDirection: Axis.vertical,
                  ),
                  items: rankingList.map((rank) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            MText.h5(
                              "${rank["position"]}위",
                              color: MColor.kLabel.neutral,
                            ),
                            const SizedBox(width: 16),
                            MText.h5(rank["name"], color: MColor.kLabel.normal),
                            const SizedBox(width: 4),
                            MText.buttonS(
                              "[${rank["score"]}점]",
                              color: MColor.kLabel.normal,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: MText.buttonSS(
                            "${rank["diff"]}↑",
                            color: MColor.kButton.active,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
