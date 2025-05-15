import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'symptom_search_result.dart';

class SymptomSearchPage extends StatefulWidget {
  const SymptomSearchPage({Key? key}) : super(key: key);

  @override
  State<SymptomSearchPage> createState() => _SymptomSearchPageState();
}

class _SymptomSearchPageState extends State<SymptomSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];

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
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '나에게 딱 맞는\n영양제를 찾아볼까요?',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Dohyeon',
                    height: 1.2,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD88E8E),
                    image: DecorationImage(
                      image: AssetImage('assets/dc_logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Text(
                  '효능/증상으로 찾기',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Dohyeon',
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.medical_services_outlined,
                  color: Color.fromARGB(255, 159, 160, 254),
                  size: 25,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '효능/증상 검색',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      searchHistory.remove(value);
                      searchHistory.insert(0, value);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SymptomSearchResultPage(searchQuery: value)),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '검색 기록',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSearchHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    if (searchHistory.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '검색 기록이 없습니다',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchHistory.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.history, color: Colors.grey[600], size: 20),
              const SizedBox(width: 12),
              Text(
                searchHistory[index],
                style: const TextStyle(fontSize: 14),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                onPressed: () {
                  setState(() {
                    searchHistory.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
