import 'package:flutter/material.dart';
import 'package:mobile_app_3/public/login_screen.dart';
import 'package:mobile_app_3/public/signup_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _ScreenState();
}

class _ScreenState extends State<IntroScreen> {
  // final Banner banner;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // logo intro screen
                      const Row(
                        children: [
                          Expanded(
                            child: Image(
                                image: AssetImage(
                                    'assets/image/banner-samsung.jpg')),
                          )
                        ],
                      ),
                      // Text title
                      const Column(
                        children: [
                          Text(
                            'Welcome to MC-SHOP',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RubikMaps'),
                          ),
                          Text(
                            'MC-SHOP nơi mua sắm uy tín hàng đầu',
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                    255, 0, 0, 0), // Màu nền của nút
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              child: const Text(
                                'Đăng nhập',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: 120,
                            child: OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                      255, 0, 0, 0), // Màu nền của nút
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  );
                                },
                                child: const Text(
                                  'Đăng ký',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
