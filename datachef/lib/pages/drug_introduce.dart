import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile_page.dart';

class DrugIntroducePage extends StatefulWidget {
  final String drugId; // 영양제 ID

  const DrugIntroducePage({Key? key, required this.drugId}) : super(key: key);

  @override
  State<DrugIntroducePage> createState() => _DrugIntroducePageState();
}

class _DrugIntroducePageState extends State<DrugIntroducePage> {
  bool isLoading = true;
  Map<String, dynamic> drugData = {};

  @override
  void initState() {
    super.initState();
    _fetchDrugDetails();
  }

  Future<void> _fetchDrugDetails() async {
    // TODO: 실제 API 호출로 대체
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      drugData = {
        'name': '비타민 C 1000',
        'brand': '종근당',
        'price': '12,900',
        'imageUrl': 'assets/vitamin_c.png',
        'dosage': '분량 / 1일 1알 / 1회',
        'effects': ['종합', '관절', '혈당', '눈', '피로'],
      };
      isLoading = false;
    });
  }

  // 이름 복사 기능
  void _copyNameToClipboard() {
    Clipboard.setData(ClipboardData(text: drugData['name'] ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('영양제 이름이 복사되었습니다'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // 복용 영양제 등록
  void _registerDrug() async {
    // TODO: 실제 등록 API 호출
    try {
      // API 호출 로직
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('복용 영양제로 등록되었습니다')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('등록 중 오류가 발생했습니다')),
      );
    }
  }

  Widget _buildEffectButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Dohyeon',
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.reply, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    drugData['name'] ?? '영양제 이름',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Dohyeon',
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 영양제 이미지
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  image: drugData['imageUrl'] != null
                      ? DecorationImage(
                          image: AssetImage(drugData['imageUrl']),
                          fit: BoxFit.contain,
                        )
                      : null,
                ),
                child: drugData['imageUrl'] == null
                    ? Center(
                        child: Text(
                          '영양제 사진',
                          style: TextStyle(
                            fontFamily: 'Dohyeon',
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 20),

              // 브랜드 및 가격 정보
              Text(
                drugData['brand'] ?? '브랜드',
                style: const TextStyle(
                  fontFamily: 'Dohyeon',
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),

              Row(
                children: [
                  Text(
                    drugData['name'] ?? '영양제 이름',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Dohyeon',
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _copyNameToClipboard,
                    child: Icon(
                      Icons.content_copy,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              Text(
                '${drugData['price']}원',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Dohyeon',
                ),
              ),

              const SizedBox(height: 20),
              // 섭취 정보
              const Text(
                '섭취정보',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(90, 0, 0, 0),
                  fontFamily: 'Dohyeon',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    drugData['dosage'] ?? '분량 / 1일 1알 / 1회',
                    style: const TextStyle(fontFamily: 'Dohyeon', fontSize: 18),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),

              // 효능 선택 버튼들
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  for (String effect in (drugData['effects'] ?? []))
                    _buildEffectButton(effect),
                ],
              ),

              const SizedBox(height: 160),
              // 등록 버튼
              ElevatedButton(
                onPressed: _registerDrug,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD88E8E),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '복용 영양제로 등록',
                  style: TextStyle(
                    fontFamily: 'Dohyeon',
                    fontSize: 20,
                    color: Colors.black,
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
