import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:team2_client/components/custom_bottom_bar.dart';

class RankBoardPage extends StatefulWidget {
  const RankBoardPage({super.key});

  @override
  State<RankBoardPage> createState() => _RankBoardPageState();
}

class _RankBoardPageState extends State<RankBoardPage> {
  final List<Map<String, String>> items = [
    {'nickname': '닉네임 1', 'rank': '1', 'time': '10초', 'level': '1'},
    {'nickname': '닉네임 2', 'rank': '2', 'time': '20초', 'level': '1'},
    {'nickname': '닉네임 3', 'rank': '3', 'time': '30초', 'level': '1'},
    {'nickname': '닉네임 4', 'rank': '4', 'time': '40초', 'level': '1'},
    {'nickname': '닉네임 5', 'rank': '5', 'time': '50초', 'level': '1'},
    {'nickname': '닉네임 6', 'rank': '6', 'time': '60초', 'level': '1'},
    {'nickname': '닉네임 7', 'rank': '7', 'time': '70초', 'level': '1'},
    {'nickname': '닉네임 8', 'rank': '8', 'time': '80초', 'level': '1'},
    {'nickname': '닉네임 9', 'rank': '9', 'time': '90초', 'level': '1'},
    {'nickname': '닉네임 10', 'rank': '10', 'time': '100초', 'level': '1'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 50),
        child: Column(
          children: [
            // SvgPicture.asset("assets/rank.svg"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "오늘의 레벨 순위",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "2025.01.18일 기준",
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return
                      // ListTile(
                      //   contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      //   title: Text(
                      //     '${item['nickname']} - ${item['rank']}',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     '시간: ${item['time']}',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // );
                      Container(
                    child: SizedBox(
                      height: 80,
                      width: 312,
                      child: Row(
                        children: [
                          Text(
                            item['rank']!,
                            style: TextStyle(
                              color: Color(0xFF85A379),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            height: 48,
                            width: 48,
                            "assets/user_img.svg",
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Lv. ${item['level']}",
                            style: TextStyle(
                              color: Color(0xFF171717),
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            item['nickname']!,
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
