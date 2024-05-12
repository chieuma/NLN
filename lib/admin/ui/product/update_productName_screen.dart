import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/admin/ui/home/home_screen.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class UpdateProductNameScreen extends StatefulWidget {
  final int productId;
  final String name;
  const UpdateProductNameScreen(
      {required this.productId, required this.name, super.key});

  @override
  State<UpdateProductNameScreen> createState() =>
      _UpdateProductNameScreenState();
}

class _UpdateProductNameScreenState extends State<UpdateProductNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _name = TextEditingController();
  @override
  void initState() {
    super.initState();
    _name.text = widget.name;
  }

  Future<void> _submit(int productId, String name) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool configSuccess = await context
          .read<ProductManager>()
          .updateProductName(productId, name);
      if (!configSuccess) {
        await showErrorDialog(context, "Cập nhật không thành công");
      } else {
        showSuccessUpdateDialog(
            context, "Cập nhật thành công!", widget.productId);
      }
    } catch (error) {
      print(error);
      await showErrorDialog(context, "Lỗi không thêm được");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cập nhật tên sản phẩm",
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
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: "Tên sản phẩm",
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        _submit(widget.productId, _name.text);
                      },
                      child: const Text(
                        "Lưu",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
