import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/public/signup_screen.dart';

import 'package:provider/provider.dart';
import '../client/services/login_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool loginSuccess = await context
          .read<LoginService>()
          .login(_usernameController.text, _passwordController.text);
      if (!loginSuccess) {
        await showErrorDialog(context, "Đăng nhập không thành công!");
      }
    } catch (error) {
      if (mounted) {
        await showErrorDialog(context, "Đăng nhập không thành công!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.black, Colors.purple],
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'ĐĂNG NHẬP',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Consumer<LoginService>(
              builder: (context, loginModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MC-SHOP',
                      style: TextStyle(fontFamily: 'RubikMaps', fontSize: 40),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            elevation: 10,
                            shadowColor: const Color.fromARGB(215, 1, 193, 210)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Tên đăng nhập',
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 29, 29, 29),
                                  fontSize: 16,
                                ),
                                hintText: 'Tên đăng nhập',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 132, 248, 0),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 5) {
                                  return 'Tên đăng nhập không được trống và chứa ít nhất 5 kí tự';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 10,
                            shadowColor: const Color.fromARGB(215, 1, 193, 210)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.key),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 132, 248, 0)),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Mật khẩu',
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 29, 29, 29),
                                  fontSize: 16,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _passwordController.text.isEmpty
                                        ? Colors.grey
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              obscureText: !_showPassword,
                              validator: (value) {
                                if (value == null || value.length < 5) {
                                  return 'Mật khẩu không được trống và chứa ít nhất 6 kí tự';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: null,
                              child: Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _submit();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: const Text(
                                'Đăng Nhập',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Hoặc',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/image/logo_google.png',
                                    ),
                                    width: 60,
                                  ),
                                  Text(
                                    'Đăng nhập với Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Bạn đã có tài khoản?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Đăng Ký',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
