import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/user_provider.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({Key? key}) : super(key: key);

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  String userId = "";
  String userEmail = "";
  bool isEditingPassword = false;
  bool isEditingEmail = false;
  bool isLoading = false;

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final String _baseUrl =
      'https://port-0-ai-startup-bootcamp-backend-ysl2blowfnha3.sel5.cloudtype.app';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // 사용자 정보 로드
  Future<void> _loadUserInfo() async {
    try {
      final currentUsername = UserProvider.username;
      if (currentUsername != null) {
        setState(() {
          userId = currentUsername;
          userEmail = UserProvider.email ?? '';
        });

        final response = await http.post(
          Uri.parse('$_baseUrl/user-info'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'username_id': currentUsername,
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            userEmail = data['email'] ?? UserProvider.email ?? '';
          });
        }
      }
    } catch (e) {
      print('사용자 정보 로드 에러: $e');
    }
  }

  // 비밀번호 변경
  Future<void> _updatePassword() async {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty) {
      _showErrorMessage('현재 비밀번호와 새 비밀번호를 모두 입력해주세요.');
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username_id': userId,
          'current_password': _currentPasswordController.text,
          'new_password': _newPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isEditingPassword = false;
        });
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _showSuccessMessage('비밀번호가 변경되었습니다.');
      } else if (response.statusCode == 401) {
        _showErrorMessage('현재 비밀번호가 올바르지 않습니다.');
      } else {
        _showErrorMessage('비밀번호 변경에 실패했습니다.');
      }
    } catch (e) {
      _showErrorMessage('네트워크 오류가 발생했습니다.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // 이메일 변경
  Future<void> _updateEmail() async {
    if (_emailController.text.isEmpty) {
      _showErrorMessage('이메일을 입력해주세요.');
      return;
    }

    setState(() => isLoading = true);

    try {
      // 요청 데이터 확인
      print('이메일 변경 요청 데이터:');
      print('username_id: $userId');
      print('email: ${_emailController.text}');

      final response = await http.post(
        Uri.parse('$_baseUrl/update-email'), // 이 URL이 맞는지 확인
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username_id': userId,
          'email': _emailController.text,
        }),
      );

      // 응답 확인
      print('서버 응답 코드: ${response.statusCode}');
      print('서버 응답 내용: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          userEmail = _emailController.text;
          isEditingEmail = false;
        });
        UserProvider.email = userEmail;
        _showSuccessMessage('이메일이 변경되었습니다.');
      } else {
        _showErrorMessage('이메일 변경에 실패했습니다. (에러코드: ${response.statusCode})');
      }
    } catch (e) {
      print('에러 발생: $e');
      _showErrorMessage('네트워크 오류가 발생했습니다.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
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
        title: Padding(
          padding: EdgeInsets.only(right: 60),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/dc_logo.png',
                  height: 30,
                  color: const Color(0xFFD88E8E),
                ),
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
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFD88E8E),
                ),
                child: const Text(
                  '개인정보 확인 및 수정',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Dohyeon',
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildInfoItem('아이디', userId, false),
                        const Divider(),
                        _buildPasswordItem(),
                        const Divider(),
                        _buildEmailItem(),
                        const Divider(),
                        _buildLinkButton('공지사항'),
                        const Divider(),
                        _buildLinkButton('이용약관'),
                        const Divider(),
                        _buildLinkButton('탈퇴', isRed: true),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            minimumSize: const Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            '나가기',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Dohyeon',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, bool hasEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '비밀번호: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: isEditingPassword
                    ? Column(
                        children: [
                          TextField(
                            controller: _currentPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '현재 비밀번호',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(color: Colors.grey[300]),
                          ),
                          TextField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '새 비밀번호',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        '***********',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  if (isEditingPassword &&
                      _currentPasswordController.text.isNotEmpty &&
                      _newPasswordController.text.isNotEmpty) {
                    _updatePassword();
                  } else {
                    setState(() {
                      isEditingPassword = !isEditingPassword;
                      if (!isEditingPassword) {
                        _currentPasswordController.clear();
                        _newPasswordController.clear();
                      }
                    });
                  }
                },
                child: Text(
                  isEditingPassword ? '완료' : '수정',
                  style: const TextStyle(
                    color: Color(0xFFD88E8E),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const Text(
            '이메일: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: isEditingEmail
                ? TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  )
                : Text(
                    userEmail,
                    style: const TextStyle(fontSize: 16),
                  ),
          ),
          GestureDetector(
            onTap: () {
              if (isEditingEmail && _emailController.text.isNotEmpty) {
                _updateEmail();
              } else {
                setState(() {
                  isEditingEmail = !isEditingEmail;
                  if (isEditingEmail) {
                    _emailController.text = userEmail;
                  }
                });
              }
            },
            child: Text(
              isEditingEmail ? '완료' : '수정',
              style: const TextStyle(
                color: Color(0xFFD88E8E),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(String title, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: () {
          // 버튼 클릭 로직
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isRed ? Colors.red : Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
