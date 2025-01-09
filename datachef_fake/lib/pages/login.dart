import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_screen.dart';
import '../providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;

  final String _baseUrl =
      'https://port-0-ai-startup-bootcamp-backend-ysl2blowfnha3.sel5.cloudtype.app';

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateUsername);
    _passwordController.addListener(_validatePassword);
  }

  void _validateUsername() {
    if (_usernameError != null) {
      setState(() {
        _usernameError =
            _usernameController.text.isNotEmpty ? null : _usernameError;
      });
    }
  }

  void _validatePassword() {
    if (_passwordError != null) {
      setState(() {
        _passwordError =
            _passwordController.text.isNotEmpty ? null : _passwordError;
      });
    }
  }

  Future<void> _login() async {
    // 입력값 검증
    setState(() {
      _usernameError = _usernameController.text.isEmpty ? '아이디를 입력해주세요' : null;
      _passwordError = _passwordController.text.isEmpty ? '비밀번호를 입력해주세요' : null;
    });

    if (_usernameError != null || _passwordError != null) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username_id': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // 로그인 성공
        final data = json.decode(response.body);
        final token = data['access_token']; // 토큰 저장이 필요한 경우 사용
        // TODO: 나중에 토큰 저장하기
        // 토큰은 나중에 다른 API 호출할 때 인증용으로 사용됩니다.
        // 예시: 자동 로그인, 개인정보 조회, 설정 변경 등
        // 저장 방법 예시: SharedPreferences 등을 사용
        // await storage.write(key: 'token', value: token);
        UserProvider.username = _usernameController.text;
        UserProvider.email = data['email'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (response.statusCode == 401) {
        // 로그인 실패
        _showErrorMessage('아이디 또는 비밀번호가 올바르지 않습니다.');
      } else {
        // 서버 오류
        _showErrorMessage('서버 오류가 발생했습니다.');
      }
    } catch (e) {
      _showErrorMessage('네트워크 오류가 발생했습니다.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  const Text(
                    '어서오세요 손님!',
                    style: TextStyle(
                      fontFamily: 'Dohyeon',
                      fontSize: 28,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 108,
                    height: 108,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD88E8E),
                      image: DecorationImage(
                        image: AssetImage('assets/dc_logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: '아이디를 입력하세요',
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            errorStyle: const TextStyle(height: 0),
                          ),
                        ),
                      ),
                      if (_usernameError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 8),
                          child: Text(
                            _usernameError!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 입력하세요',
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            errorStyle: const TextStyle(height: 0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 8),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD88E8E),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '로그인하기',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.removeListener(_validateUsername);
    _passwordController.removeListener(_validatePassword);
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
