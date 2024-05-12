import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/public/login_screen.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord1 = TextEditingController();
  final TextEditingController _passWord2 = TextEditingController();

  bool _showPassword1 = false;
  bool _showPassword2 = false;

  @override
  void initState() {
    super.initState();
    _userName.clear();
    _email.clear();
    _passWord1.clear();
    _passWord2.clear();
    context.read<UserManager>().fetchAllUser();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool signup = await context
          .read<UserManager>()
          .signUp(_userName.text, _email.text, _passWord1.text);
      if (!signup) {
        showErrorDialog(context, "Đăng ký không thành công");
      } else {
        showSuccessDialog(
            context, "Đăng ký thành công vui lòng đăng nhập để sử dụng");
      }
    } catch (error) {
      await showErrorDialog(context, "Đăng ký không thành công!");
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
                colors: [Colors.black, Colors.purple]),
          )),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Quay lại trang trước đó khi nhấp vào biểu tượng
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'ĐĂNG KÝ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/image/logo_signup.png'),
                    width: 100,
                  )
                ],
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
                        controller: _userName,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Tên đăng nhập',
                          hintStyle: TextStyle(fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Tên đăng nhập không được trống";
                          } else if (value.length < 6) {
                            return "Tên đăng nhập chứa ít nhất 6 kí tự";
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
                        controller: _email,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email',
                            hintStyle: TextStyle(fontWeight: FontWeight.w600),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          final RegExp emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (value!.isEmpty) {
                            return "Email không được trống";
                          } else if (!emailRegex.hasMatch(value)) {
                            return "Email nhập không đúng định dạng";
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
                        controller: _passWord1,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key),
                          hintText: 'Mật khẩu',
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword1 = !_showPassword1;
                              });
                            },
                            icon: Icon(
                              _showPassword1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: (_passwordController.text.isEmpty)
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        obscureText: !_showPassword1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mật khẩu không được trống";
                          } else if (value.length < 6) {
                            return "Mật khẩu chứa ít nhất 6 kí tự";
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
                        controller: _passWord2,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key),
                          hintText: 'Nhập lại mật khẩu',
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword2 = !_showPassword2;
                              });
                            },
                            icon: Icon(
                              _showPassword2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: (_passwordController.text.isEmpty)
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        obscureText: !_showPassword2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mật khẩu không được trống";
                          } else if (value.length < 6) {
                            return "Mật khẩu chứa ít nhất 6 kí tự";
                          } else if (value != _passWord1.text) {
                            return "Không trùng khớp mật khẩu, vui lòng nhập lại";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _submit();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Login()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Đăng Ký',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn đã có tài khoản?',
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text(
                            'Đăng Nhập',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
