import 'package:flutter/material.dart';
import 'drug_introduce.dart';

class Supplement {
  final String name;
  final int price;
  final String drugId;

  Supplement({
    required this.name,
    required this.price,
    required this.drugId,
  });
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Supplement> supplements = [];

  @override
  void initState() {
    super.initState();
    // 초기 데이터 설정
    supplements = [
      Supplement(
        name: '비타민 C 1000',
        price: 12900,
        drugId: 'vitamin_c_1000',
      ),
      Supplement(
        name: '종합 비타민',
        price: 15900,
        drugId: 'multi_vitamin',
      ),
      Supplement(
        name: '프로바이오틱스',
        price: 25900,
        drugId: 'probiotics',
      ),
      Supplement(
        name: '오메가3',
        price: 18900,
        drugId: 'omega3',
      ),
      Supplement(
        name: '마그네슘',
        price: 14900,
        drugId: 'magnesium',
      ),
    ];
  }

  void removeItem(int index) {
    setState(() {
      supplements.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset('assets/dc_logo.png', height: 28),
            ),
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
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: supplements.length,
              itemBuilder: (context, index) {
                final supplement = supplements[index];
                return _buildSupplementItem(supplement, index);
              },
            ),
    );
  }

  Widget _buildSupplementItem(Supplement supplement, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrugIntroducePage(drugId: supplement.drugId),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
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
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(
                  child:
                      Icon(Icons.medication, size: 40, color: Colors.grey[400]),
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
                        fontSize: 20,
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${supplement.price}원',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => removeItem(index),
                icon: Icon(
                  Icons.close,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 150),
        Image.asset(
          'assets/my_drawer.png',
          height: 270,
          fit: BoxFit.contain,
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
            onPressed: () => Navigator.pop(context),
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
}
