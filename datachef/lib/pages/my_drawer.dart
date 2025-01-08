import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'drug_introduce.dart';

class Supplement {
  final String image;
  final String name;
  final int price;
  final String drugId;

  Supplement({
    required this.image,
    required this.name,
    required this.price,
    required this.drugId,
  });
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Supplement> supplements = [
      Supplement(
        image: 'assets/supplement_image.png',
        name: '비타민 C 1000',
        price: 12900,
        drugId: 'vitamin_c_1000',
      ),
      Supplement(
        image: 'assets/supplement_image.png',
        name: '종합 비타민',
        price: 15900,
        drugId: 'multi_vitamin',
      ),
    ];

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
              '나의 서랍장',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Dohyeon',
              ),
            ),
          ],
        ),
      ),
      body: supplements.isEmpty
          ? _buildEmptyState(context)
          : _buildSupplementList(supplements),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 150),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            'assets/my_drawer.png',
            height: 270,
            fit: BoxFit.contain,
          ),
        ),
        const Spacer(),
        const Text(
          '마음에 드는 영양제를',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const Text(
          '저장해보세요!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70),
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD88E8E),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '영양제 등록하기',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Dohyeon',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupplementList(List<Supplement> supplements) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: supplements.length,
      itemBuilder: (context, index) {
        final supplement = supplements[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DrugIntroducePage(drugId: supplement.drugId),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      supplement.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supplement.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Dohyeon',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${supplement.price.toString()}원',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFD88E8E),
                            fontFamily: 'Dohyeon',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
