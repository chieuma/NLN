import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/client/ui/shop/category_manager.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _name = TextEditingController();

  @override
  Future<void> _submit(String name) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool success = await context.read<CategoryManager>().addCategory(name);

      if (!success) {
        await showErrorDialog(context, 'Thêm không thành công');
      } else {
        await showSuccessDialog(context, 'Thêm loại sản phẩm thành công');
        setState(() {
          _name.text = '';
        });
      }
    } catch (error) {
      await showErrorDialog(context, "Lỗi không thêm được loại sản phẩm");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm loại sản phẩm",
          style: GoogleFonts.aBeeZee(),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Material(
                      elevation: 10,
                      shadowColor:
                          Color.fromARGB(255, 0, 211, 109).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(
                            labelText: "Nhập tên loại sản phẩm",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Tên loại không được trống";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submit(_name.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "Thêm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
