import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffe0e0e0), // 테두리 색상
            width: 1, // 테두리 두께
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFA3BE98),
        unselectedItemColor: Color(0xffbdbdbd),
        selectedLabelStyle: TextStyle(
          color: Color(0xFFA3BE98),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.20,
        ),
        unselectedLabelStyle: TextStyle(
          color: Color(0xffbdbdbd),
          fontSize: 11,
          fontWeight: FontWeight.w400,
          height: 1.20,
        ),
        items: <BottomNavigationBarItem>[
          // 괴롭히기
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/meh.png',
                width: 24,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/meh_active.png',
                width: 24,
              ),
            ),
            label: '괴롭히기',
          ),
          // 랭킹
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/ranking.png',
                width: 24,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/ranking_active.png',
                width: 24,
              ),
            ),
            label: '랭킹',
          ),
          // 챗봇
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/chat.png',
                width: 24,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/chat_active.png',
                width: 24,
              ),
            ),
            label: '챗봇',
          ),
          // 나의 기록
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/activity.png',
                width: 24,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/activity.png',
                width: 24,
              ),
            ),
            label: '나의 기록',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/game');
              break;
            case 1:
              // 랭킹
              break;
            case 2:
              Get.toNamed('/chat');
              break;
            case 3:
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
