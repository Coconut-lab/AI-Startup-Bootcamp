// lib/screens/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'my_drawer.dart';
import 'user_edit.dart';
import '../providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = UserProvider.username ?? 'OOO';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.reply, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset('assets/dc_logo.png', height: 28),
            const SizedBox(width: 8),
            const Text(
              '나의 페이지',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Dohyeon',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          // Profile Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.person_outline,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$username 님',
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                    const Text(
                      '오늘도 건강하세요!',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Dohyeon',
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserEditPage()),
                          );
                        },
                        child: const Text(
                          '개인 정보 확인 및 수정',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(123, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Storage Section Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDrawer()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD88E8E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/my_drawer.png',
                    height: 28,
                    width: 28,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '나의 서랍장 보러가기',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontFamily: 'Dohyeon',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
