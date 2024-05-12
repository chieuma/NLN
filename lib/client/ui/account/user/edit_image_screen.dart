import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? imageFile;
  late String imageData = '';

  choiceImage() async {
    var pickerimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerimage != null) {
      setState(() {
        imageFile = File(pickerimage.path);
      });
      imageData = base64Encode(imageFile!.readAsBytesSync());
      return imageData;
    } else {
      return null;
    }
  }

  showImage(String image) {
    return Image.memory(
      base64Decode(image),
      width: 400,
      height: 400,
    );
  }

  Future<void> _submit() async {
    if (imageData.isEmpty) {
      await showErrorDialog(context, "Chưa có ảnh nào được chọn");
    } else {
      try {
        bool success = await context
            .read<UserManager>()
            .uploadImage(imageData, context.read<LoginService>().userId);
        if (!success) {
          await showErrorDialog(context, "Đổi ảnh đại diện không thành công");
        } else {
          await showSuccessDialog(context, "Bạn đã đổi ảnh thành công");
        }
      } catch (error) {
        await showErrorDialog(context, "Lỗi trong quá trình đổi ảnh đại diện");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ảnh Đại Diện',
          style: TextStyle(fontWeight: FontWeight.bold),
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
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageData == ''
                ? const Text(
                    'Không có ảnh nào được chọn',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : Column(
                    children: [
                      showImage(imageData),
                      const SizedBox(height: 20),
                    ],
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: choiceImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Chọn ảnh',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                _submit();
              },
              child: const Text(
                'Cập nhật ảnh',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
