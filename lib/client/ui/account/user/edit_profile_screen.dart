import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel? fetchUser;
  const EditProfileScreen({required this.fetchUser, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullName.text = widget.fetchUser!.fullName ?? '';
    _email.text = widget.fetchUser!.email ?? '';
    _tel.text = widget.fetchUser!.tel ?? '';
    _address.text = widget.fetchUser!.address ?? '';
  }

  Future<void> _submit(UserModel? newUser) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool success = await context.read<UserManager>().editProfile(newUser);

      if (!success) {
        await showErrorDialog(context, 'Cập nhật không thành công');
      } else {
        await showSuccessDialog(context, 'Cập nhật thành công');
      }
    } catch (error) {
      await showErrorDialog(context, "Lỗi không thêm được sản phẩm");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chỉnh Sửa Thông Tin Cá Nhân',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.black, Colors.purple]),
          ),
        ),
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
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 236, 67, 67)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _fullName,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText:
                                  widget.fetchUser!.fullName ?? "Họ Và Tên",
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              hintText: 'Ví dụ: Mã Văn Chiều',
                              border: const OutlineInputBorder()),
                          validator: (value) {
                            if (value!.length < 10) {
                              return "Tên chứa ít nhất 10 ký tự và không chứa ký tự đặt biệt";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 236, 67, 67)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            labelText: widget.fetchUser!.email ?? 'Email',
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            hintText: 'Ví dụ: vanchieu.at3.st@gmail.com',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            final RegExp emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value!)) {
                              return "Email nhập không đúng định dạng";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 236, 67, 67)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _tel,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            labelText: widget.fetchUser!.tel ?? 'Số Điện Thoại',
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            hintText: 'Ví dụ: 0369961760',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.length < 10 || value!.length > 10) {
                              return "Số điện thoại chứa đúng 10 số";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 236, 67, 67)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 2,
                          controller: _address,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.contact_mail),
                            labelText:
                                widget.fetchUser!.address ?? "Địa Chỉ Liên Hệ",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            hintText:
                                'Ví dụ: Đường 30/4, Phường Hưng Lợi, Quận Ninh Kiều, Cần Thơ',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.length < 10) {
                              return "Địa chỉ chứa ít nhất 10 ký tự";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    side: const BorderSide(
                                        width: 0.8, color: Colors.black)),
                                child: const Text(
                                  'HỦY',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  UserModel? newUser = UserModel(
                                    id: widget.fetchUser!.id,
                                    name: widget.fetchUser!.name,
                                    password: widget.fetchUser!.password,
                                    fullName: _fullName.text,
                                    email: _email.text,
                                    address: _address.text,
                                    tel: _tel.text,
                                    date: widget.fetchUser!.date,
                                    image: widget.fetchUser!.image,
                                    role: widget.fetchUser!.role,
                                  );
                                  _submit(newUser);
                                  // context
                                  //     .read<UserManager>()
                                  //     .editProfile(newUser);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    side: const BorderSide(
                                        width: 0.8, color: Colors.black)),
                                child: const Text(
                                  'LƯU',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
