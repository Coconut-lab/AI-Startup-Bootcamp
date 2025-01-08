import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'login.dart';
import 'signup_screen.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: const AssetImage('assets/pharmacy_bg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  Container(
                    width: 108,
                    height: 108,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD88E8E),
                      image: const DecorationImage(
                        image: AssetImage('assets/dc_logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '데이터캡슐로부터\n영양제 추천을 받아볼까요?',
                    style: TextStyle(
                        fontFamily: 'Dohyeon',
                        fontSize: 32,
                        height: 1.5,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                          )
                        ]),
                  ),
                  const SizedBox(height: 300),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD88E8E),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '시작하기',
                      style: TextStyle(
                        fontFamily: 'Dohyeon',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          '이미 계정이 있으신가요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            splashColor: Color(0xFFD88E8E).withOpacity(0.3),
                            highlightColor: Color(0xFFD88E8E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            child: const Text(
                              '로그인하기',
                              style: TextStyle(
                                  fontFamily: 'Dohyeon',
                                  fontSize: 18,
                                  color: Color(0xFFD88E8E),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFFD88E8E)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.5,
                            letterSpacing: 0.3,
                          ),
                          children: [
                            const TextSpan(
                              text: '시작하시게 되면 ',
                            ),
                            TextSpan(
                              text: '이용약관',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                color: Color(0xFFFFFFFF),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // 이용약관 페이지로 이동
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => const TermsPage()),
                                  // );
                                },
                            ),
                            const TextSpan(
                              text: ' 및 ',
                            ),
                            TextSpan(
                              text: '개인정보 수집 및 이용',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                color: Color(0xFFFFFFFF),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // 개인정보 처리방침 페이지로 이동
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => const PrivacyPage()),
                                  // );
                                },
                            ),
                            const TextSpan(
                              text: '에\n자동 동의됩니다.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
