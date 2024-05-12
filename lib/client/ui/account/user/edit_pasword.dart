import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/main.dart';
import 'package:mobile_app_3/public/intro_screen.dart';
import 'package:provider/provider.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final TextEditingController _pass1 = TextEditingController();
  bool _showPass1 = false;
  final TextEditingController _pass2 = TextEditingController();
  bool _showPass2 = false;
  final TextEditingController _pass3 = TextEditingController();
  bool _showPass3 = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pass1.clear();
    _pass2.clear();
    _pass3.clear();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool success = await context.read<LoginService>().editPassword(
          context.read<LoginService>().userId, _pass1.text, _pass2.text);
      if (!success) {
        await showErrorDialog(context, 'Thay đổi mật khẩu không thành công');
      } else {
        await showSuccessDialog(context, "Thay đổi mật khẩu thành công");
      }
    } catch (errror) {
      await showErrorDialog(
          context, "Có lỗi trong quá trình thay đổi mật khẩu");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thay Đổi Mật Khẩu',
          style: GoogleFonts.aBeeZee(),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 181, 181, 181),
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () {
            // Quay lại trang trước đó khi nhấp vào biểu tượng
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _pass1,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key),
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          hintText: 'Nhập mật khẩu hiện tại',
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPass1 = !_showPass1;
                              });
                            },
                            icon: Icon(
                              _showPass1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _showPass1 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: !_showPass1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mật khẩu không được trống";
                          } else if (value.length < 6) {
                            return "Mật khẩu ít nhất 6 kí tự";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _pass2,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          hintText: 'Nhập mật khẩu mới',
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPass2 = !_showPass2;
                              });
                            },
                            icon: Icon(
                              _showPass2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _showPass2 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: !_showPass2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mật khẩu mới không được trống";
                          } else if (value.length < 6) {
                            return "Mật khẩu ít nhất 6 kí tự";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _pass3,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          hintText: 'Nhập lại mật khẩu mới',
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPass3 = !_showPass3;
                              });
                            },
                            icon: Icon(
                              _showPass3
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _showPass3 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: !_showPass3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mật khẩu không được trống";
                          } else if (value != _pass2.text) {
                            return "Mật khẩu mới không trùng khớp";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _pass1.clear();
                                _pass2.clear();
                                _pass3.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              side: const BorderSide(
                                  width: 0.8, color: Colors.black),
                              shadowColor: Colors.black,
                              elevation: 20,
                            ),
                            child: const Text(
                              'Hủy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _submit();

                              // Fluttertoast.showToast(
                              //     msg:
                              //         "Bạn đã thay đổi mật khẩu thành công, vui lòng đăng nhập lại để sử dụng",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.TOP,
                              //     backgroundColor:
                              //         const Color.fromARGB(255, 214, 107, 25));
                              // context.read<LoginService>().logout();
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const AppWrapper()),
                              //   (Route<dynamic> route) => false,
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              shadowColor: Colors.black,
                              elevation: 20,
                            ),
                            child: const Text(
                              'Lưu',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side: const BorderSide(width: 0.8, color: Colors.black),
                        shadowColor: Colors.black,
                        elevation: 10,
                      ),
                      child: const Text(
                        'Thay đổi mật khẩu thông qua SMS',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side: const BorderSide(width: 0.8, color: Colors.black),
                        shadowColor: Colors.black,
                        elevation: 10,
                      ),
                      child: const Text(
                        'Thay đổi mật khẩu thông qua Email',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
