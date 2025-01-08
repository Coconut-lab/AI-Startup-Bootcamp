import 'package:flutter/material.dart';
import 'drug_introduce.dart';

class DetailSearchResultPage extends StatefulWidget {
  final String searchQuery;

  const DetailSearchResultPage({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  State<DetailSearchResultPage> createState() => _DetailSearchResultPageState();
}

class _DetailSearchResultPageState extends State<DetailSearchResultPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
    _fetchSearchResults(widget.searchQuery);
  }

  Future<void> _fetchSearchResults(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // TODO: 실제 API 호출로 대체
      await Future.delayed(Duration(seconds: 1));

      // 더미 데이터 (실제 API 응답 구조에 맞게 수정 필요)
      final dummyData = [
        {
          'id': '1',
          'name': '비타민 C 1000',
          'brand': '종근당',
          'imageUrl': 'assets/vitamin_c.png',
          'price': '12,900',
          'benefits': ['면역력 증진', '피로 회복'],
          'dosage': '1일 1회, 1회 1정'
        },
        {
          'id': '2',
          'name': '종합 비타민',
          'brand': '센트룸',
          'imageUrl': 'assets/multivitamin.png',
          'price': '25,000',
          'benefits': ['영양 보충', '활력 증진'],
          'dosage': '1일 1회, 1회 1정'
        },
      ];

      setState(() {
        searchResults = dummyData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = '검색 중 오류가 발생했습니다';
        isLoading = false;
      });
    }
  }

  void _navigateToDrugDetail(Map<String, dynamic> drug) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugIntroducePage(drugId: drug['id']),
      ),
    );
  }

  Widget _buildSearchResult(Map<String, dynamic> result) {
    return GestureDetector(
      onTap: () => _navigateToDrugDetail(result),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Dohyeon',
                        ),
                      ),
                      if (result['brand'] != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          result['brand'],
                          style: TextStyle(
                            fontFamily: 'Dohyeon',
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (result['price'] != null)
                  Text(
                    '${result['price']}원',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Dohyeon',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            ...(result['benefits'] as List).map(
              (benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $benefit',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          children: [
            Image.asset('assets/dc_logo.png', height: 30, color: Colors.black),
            const SizedBox(width: 8),
            const Text(
              '영양제 세부검색',
              style: TextStyle(
                fontFamily: 'Dohyeon',
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '영양제 성분 검색',
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
                    _fetchSearchResults(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '"${widget.searchQuery}검색 결과"',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                      ? Center(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        )
                      : searchResults.isEmpty
                          ? Center(
                              child: Text(
                                '검색 결과가 없습니다',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                return _buildSearchResult(searchResults[index]);
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
