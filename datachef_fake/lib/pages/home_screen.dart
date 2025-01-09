//lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'symptom_search.dart';
import 'detail_search.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  final String? username;

  const HomeScreen({Key? key, this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/dc_logo.png',
                height: 30, color: Color(0xFFD88E8E)),
            const SizedBox(width: 2),
            const Text(
              'Datachef',
              style: TextStyle(
                fontFamily: 'Dohyeon',
                color: Color(0xFFD88E8E),
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.person_outline, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나에게 딱 맞는',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                    Text(
                      '영양제를 찾아볼까요?',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFD88E8E),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset('assets/dc_logo.png', width: 65),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SymptomSearchPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '효능/증상으로 찾기',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Dohyeon',
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.medical_services,
                            size: 30, color: Colors.blue),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '원하는 효능이나 나의 증상으로 찾아봐요!',
                      style: TextStyle(
                        fontFamily: 'Dohyeon',
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailSearchPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '영양제 세부검색',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Dohyeon',
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.medication,
                            size: 35,
                            color: const Color.fromARGB(255, 124, 80, 145)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '영양제의 자세한 성분을 찾아봐요!',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Dohyeon',
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
