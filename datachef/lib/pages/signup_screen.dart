import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _privacyPolicyAccepted = false;
  bool _isUsernameDuplicate = false;
  bool _isUsernameChecked = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onUsernameChanged);
  }

  void _onUsernameChanged() {
    if (_isUsernameChecked) {
      setState(() {
        _isUsernameChecked = false;
      });
    }
  }

  void _checkDuplicateUsername() {
    if (_usernameController.text.length < 4) {
      setState(() {
        _isUsernameDuplicate = true;
        _isUsernameChecked = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('아이디는 4글자 이상이어야 합니다.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isUsernameDuplicate = false;
      _isUsernameChecked = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용 가능한 아이디입니다.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _showPrivacyPolicyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('회원가입에 실패했습니다'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(
                    'assets/dc_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '개인정보 처리방침',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Dohyeon',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '수집되는 개인정보는 아이디, 비밀번호, 이메일, 검색기록으로 제한되며, 이는 맞춤형 영양제 추천 서비스 제공과 서비스 개선을 위한 목적으로만 사용됩니다. 모든 개인정보는 암호화되어 안전하게 관리되며, 회원은 언제든지 개인정보 열람 및 삭제를 요청할 수 있습니다. 법적 요구사항을 제외하고는 어떠한 경우에도 제3자에게 개인정보를 제공하지 않으며, 회원 탈퇴 시 즉시 개인정보를 파기합니다. 개인정보 보호를 위해 최신 보안 기술을 적용하고 최소한의 인원만이 접근할 수 있도록 엄격하게 관리합니다.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD88E8E),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _privacyPolicyAccepted = true;
                      });
                      Navigator.pop(context);
                      _proceedWithSignup();
                    },
                    child: const Text(
                      '동의',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Dohyeon',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _proceedWithSignup() {
    if (_privacyPolicyAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입이 완료되었습니다.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: _usernameController.text),
        ),
      );
    }
  }

  void _signUp() {
    if (_validateInputs()) {
      _showPrivacyPolicyDialog();
    }
  }

  bool _validateInputs() {
    if (_usernameController.text.isEmpty) {
      _showErrorSnackBar('아이디를 입력해주세요.');
      return false;
    }

    if (!_isUsernameChecked) {
      _showErrorSnackBar('아이디 중복 확인을 해주세요.');
      return false;
    }

    if (_isUsernameDuplicate) {
      _showErrorSnackBar('사용할 수 없는 아이디입니다.');
      return false;
    }

    if (_passwordController.text.isEmpty) {
      _showErrorSnackBar('비밀번호를 입력해주세요.');
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorSnackBar('비밀번호가 일치하지 않습니다.');
      return false;
    }

    if (_emailController.text.isEmpty ||
        !_isValidEmail(_emailController.text)) {
      _showErrorSnackBar('유효한 이메일을 입력해주세요.');
      return false;
    }

    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.removeListener(_onUsernameChanged);
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.reply, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              toolbarHeight: 70,
              title: Row(
                children: [
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Dohyeon',
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'assets/dc_logo.png',
                      color: const Color(0xFFD88E8E),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '아이디를 입력해주세요',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Dohyeon',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: '아이디를 입력하세요',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _isUsernameDuplicate
                              ? '사용할 수 없는 아이디입니다.'
                              : _isUsernameChecked
                                  ? null
                                  : '중복 확인이 필요합니다.',
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: _checkDuplicateUsername,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        minimumSize: const Size(100, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        '중복 확인',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Dohyeon',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  '비밀번호를 입력해주세요',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Dohyeon',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '비밀번호를 다시 한번 입력해주세요',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Dohyeon',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '이메일을 입력해주세요',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Dohyeon',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: '이메일을 입력하세요',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD88E8E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '회원가입 완료',
                    style: TextStyle(
                      fontFamily: 'Dohyeon',
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
