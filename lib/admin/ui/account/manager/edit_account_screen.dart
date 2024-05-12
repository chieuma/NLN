import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  final UserModel user;
  const EditAccountScreen({required this.user, super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _username.text = widget.user.name;
    _fullname.text = widget.user.fullName ?? '';
    _password.text = widget.user.password;
    _email.text = widget.user.email ?? '';
    _tel.text = widget.user.tel ?? '';
    _address.text = widget.user.address ?? '';
  }

  void clear() {
    _username.clear();
    _fullname.clear();
    _password.clear();
    _email.clear();
    _tel.clear();
    _address.clear();
  }

  Future<void> _submit(UserModel userModel) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool success = await context.read<UserManager>().updateUser(userModel);
      if (!success) {
        await showErrorDialog(context, "Cập nhật không thành công");
      } else {
        await showSuccessDialog(context, "Cập nhật thành công");
      }
    } catch (error) {
      await showErrorDialog(context, "Có lỗi trong quá trình cập nhật");
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cập nhật tài khoản",
          style: GoogleFonts.aBeeZee(),
        ),
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
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Tài Khoản",
                      style: GoogleFonts.actor(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.user.name,
                      style: GoogleFonts.aBeeZee(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        shadowColor: Color.fromARGB(255, 88, 140, 3),
                        elevation: 5,
                        child: TextFormField(
                          controller: _fullname,
                          decoration: const InputDecoration(
                            hintText: "Vui lòng nhập tên đầy đủ",
                            suffixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Tên đầy đủ không được trống";
                            } else if (value.length > 30) {
                              return "Tên đầy đủ chứa tối đa 30 kí tự";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        shadowColor: Color.fromARGB(255, 88, 140, 3),
                        elevation: 5,
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              hintText: "Vui lòng nhập email"),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        shadowColor: Color.fromARGB(255, 88, 140, 3),
                        elevation: 5,
                        child: TextFormField(
                          controller: _tel,
                          decoration: const InputDecoration(
                            hintText: "Vui lòng nhập số điện thoại",
                            suffixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.length < 10 ||
                                value.length > 10) {
                              return "Số điện thoại chứa đúng 10 kí tự";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        shadowColor: Color.fromARGB(255, 88, 140, 3),
                        elevation: 5,
                        child: TextFormField(
                          controller: _address,
                          decoration: const InputDecoration(
                            hintText: "Vui lòng nhập địa chỉ",
                            suffixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.length > 30 ||
                                value.length < 10) {
                              return "Địa chỉ chứa ít nhất 10 nhiều nhất 30 kí tư";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            clear();
                          },
                          child: const Text(
                            "Hủy",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          onPressed: () {
                            UserModel userModel = UserModel(
                                id: widget.user.id,
                                name: _username.text,
                                address: _address.text,
                                tel: _tel.text,
                                email: _email.text,
                                role: widget.user.role,
                                password: widget.user.password,
                                fullName: _fullname.text,
                                date: widget.user.date);

                            _submit(userModel);
                          },
                          child: const Text(
                            "Lưu",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
