import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_3/admin/ui/product/addProduct.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/_getColor.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final int productId;
  final ProductDetailModel product;
  const EditProductScreen(
      {required this.productId, required this.product, super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _colorVn = TextEditingController();
  Color _selectedColor = Colors.black;
  late String _selectedColorName;

  late List<TextEditingController> _memoryController;
  late List<TextEditingController> _priceController;
  late List<TextEditingController> _quantityController;

  final List<String> _memory = [];
  final List<String> _price = [];
  final List<String> _quantity = [];

  File? imageFile;
  late List<String> imageData = [];

  @override
  void initState() {
    super.initState();
    _selectedColorName = widget.product.colorName!;
    _colorVn.text = widget.product.colorNameVn!;

    _memoryController = List.generate(
      widget.product.memoryOptions.length,
      (index) =>
          TextEditingController(text: widget.product.memoryOptions[index]),
    );

    _priceController = List.generate(
      widget.product.priceOptions.length,
      (index) =>
          TextEditingController(text: widget.product.priceOptions[index]),
    );

    _quantityController = List.generate(
      widget.product.quantityOptions.length,
      (index) =>
          TextEditingController(text: widget.product.quantityOptions[index]),
    );

    for (var bytes in widget.product.imageUrls!) {
      String base64String = base64Encode(bytes);
      imageData.add(base64String);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      for (var controller in _memoryController) {
        _memory.add(controller.text);
      }
      for (var controller in _priceController) {
        _price.add(controller.text);
      }
      for (var controller in _quantityController) {
        _quantity.add(controller.text);
      }
      ProductDetailModel product = ProductDetailModel(
        opt: widget.product.opt,
        memoryOptions: _memory,
        priceOptions: _price,
        quantityOptions: _quantity,
        colorName: _selectedColorName,
        colorNameVn: _colorVn.text,
        colorId: widget.product.colorId,
        imageId: widget.product.imageId,
      );
      // print("length" + imageData.length.toString());
      bool configSuccess =
          await context.read<ProductManager>().editProduct(product, imageData);
      if (!configSuccess) {
        await showErrorDialog(context, "Cập nhật không thành công");
        imageData.clear();
      } else {
        showSuccessUpdateDialog(
            context, "Cập nhật thành công", widget.productId);
      }
    } catch (error) {
      print(error);
      await showErrorDialog(context, "Lỗi không thêm được");
    }
  }

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn một màu'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                  _selectedColorName = getColorName(color);
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  choiceImage(int index) async {
    var pickerimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerimage != null) {
      setState(() {
        imageFile = File(pickerimage.path);
        imageData[index] = base64Encode(imageFile!.readAsBytesSync());
        print(imageData[index]);
      });

      return imageData;
    }
  }

  show(String image) {
    return Image.memory(
      base64Decode(image),
      width: 300,
      height: 300,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cập nhật thông tin màu sắc",
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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Material(
                      shadowColor: Colors.black,
                      elevation: 4,
                      child: TextFormField(
                        controller: _colorVn,
                        decoration: const InputDecoration(
                          labelText: 'Màu',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Màu đã chọn',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // const SizedBox(
                          //   width: 50,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: getColorFromString(_selectedColorName),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {
                              _showColorPickerDialog(context);
                            },
                            child: const Text(
                              'Chọn màu',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          'Thông tin bộ nhớ, giá và số lượng',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.33),
                        1: FlexColumnWidth(0.33),
                        2: FlexColumnWidth(0.33),
                      },
                      children: [
                        const TableRow(
                          children: [
                            TableCell(
                              child: Text(
                                'Bộ nhớ(GB)',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Giá(VND)',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Số lượng',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        for (int i = 0; i < _memoryController.length; i++)
                          TableRow(
                            children: [
                              TableCell(
                                child: TextFormField(
                                  controller: _memoryController[i],
                                ),
                              ),
                              TableCell(
                                child: TextFormField(
                                  controller: _priceController[i],
                                ),
                              ),
                              TableCell(
                                child: TextFormField(
                                  controller: _quantityController[i],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Ảnh',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 350,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageData.length,
                            itemBuilder: (context, indexImage) {
                              return Column(
                                children: [
                                  show(imageData[indexImage]),
                                  ElevatedButton(
                                    onPressed: () {
                                      choiceImage(indexImage);
                                    },
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
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 117, 74),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        "Lưu",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
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
