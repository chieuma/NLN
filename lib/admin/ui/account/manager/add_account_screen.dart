import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord1 = TextEditingController();
  final TextEditingController _passWord2 = TextEditingController();

  List<String> role = ['client', 'admin', 'staff'];
  int indexRole = 0;
  String stringRole = 'client';
  bool _showPassword1 = false;
  bool _showPassword2 = false;

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
      print(stringRole);
      return;
    }
    try {
      bool signup = await context.read<UserManager>().signUpAdmin(
          _userName.text, _email.text, _passWord1.text, stringRole);
      if (!signup) {
        showErrorDialog(context, "Đăng ký không thành công");
      } else {
        showSuccessAddAccountDialog(
            context, "Đăng ký thành công vui lòng đăng nhập để sử dụng");
      }
    } catch (error) {
      await showErrorDialog(context, "Đăng ký không thành công!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 219, 154, 231),
                Color.fromARGB(255, 247, 205, 205),
              ],
            ),
          ),
        ),
        title: Text(
          'Thêm tài khoản',
          style: GoogleFonts.aBeeZee(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shadowColor: Colors.amberAccent,
                      elevation: 5,
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
                      shadowColor: Colors.amberAccent,
                      elevation: 5,
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
                      shadowColor: Colors.amberAccent,
                      elevation: 5,
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
                      shadowColor: Colors.amberAccent,
                      elevation: 5,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < role.length; i++)
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: indexRole == i
                                      ? Colors.black
                                      : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  side: const BorderSide(color: Colors.black),
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      indexRole = i;
                                      stringRole = role[i];
                                    },
                                  );
                                },
                                child: Text(
                                  role[i],
                                  style: TextStyle(
                                      color: indexRole == i
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 159, 51),
                          ),
                          child: const Text(
                            'Thêm',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
