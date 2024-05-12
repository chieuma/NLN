import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_3/client/models/brand.dart';
import 'package:mobile_app_3/client/models/category.dart';
import 'package:mobile_app_3/client/models/color.dart';
import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/_getColor.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/client/ui/shop/brand_manager.dart';
import 'package:mobile_app_3/client/ui/shop/category_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController _name = TextEditingController();
  late TextEditingController _color = TextEditingController();
  final TextEditingController _memory = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

  List<String> memory = [];
  List<String> price = [];
  List<String> quantity = [];

  int _selectedCategoryId = 0;
  @override
  void initState() {
    super.initState();
    context.read<ProductManager>().fetchPhone();
    context.read<BrandManager>().fetchBrand();
    _name = TextEditingController();
    _color = TextEditingController();
    _selectedCategoryId = 0;
  }

  int _selectedBrand = 0;
  int _selectedIndexBrand = 0;
  String _selectedItem = '';
  Color _selectedColor = Colors.black;
  String _selectedColorName = 'black';

  int lengthBrand = 0;

  File? imageFile;
  List<File>? imageFiles = [];
  late List<String> imageData = [];

  //File imageFiles; // Danh sách các ảnh được chọn

  Future<void> _submit(ProductModel product, ColorsModel color,
      ProductDetailModel productDetail, List<String> imageData) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool success = await context
          .read<ProductManager>()
          .addProduct(product, color, productDetail, imageData);

      if (!success) {
        await showErrorDialog(context, 'Thêm không thành công');
        imageData.clear();
      } else {
        await showSuccessAdd(context, 'Thêm sản phẩm thành công');
        imageData.clear();
        imageFiles!.clear();
      }
    } catch (error) {
      await showErrorDialog(context, "Lỗi không thêm được sản phẩm");
      imageData.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm Sản Phẩm Mới",
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
        // actions: [],
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
                    Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 236, 67, 67)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _name,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Tên sản phẩm",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          // ignore: prefer_is_empty
                          if (value!.length < 0 || value.isEmpty) {
                            return "Tên không được trống";
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: Consumer<CategoryManager>(
                            builder: (context, categoryManager, child) {
                              if (categoryManager.itemCategory.isNotEmpty) {
                                List<DropdownMenuItem<int>> dropdownItems = [];
                                for (int i = 0;
                                    i < categoryManager.itemCategory.length;
                                    i++) {
                                  CategoryModel category =
                                      categoryManager.itemCategory[i];
                                  dropdownItems.add(
                                    DropdownMenuItem(
                                      value: i,
                                      child: Text(
                                        category.name,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                }
                                return DropdownButton<int>(
                                  value: _selectedCategoryId,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor:
                                      const Color.fromARGB(255, 233, 221, 221),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  items: dropdownItems,
                                  onChanged: (int? selectedIndex) {
                                    setState(() {
                                      _selectedCategoryId = selectedIndex!;
                                      // Khi category thay đổi, gọi phương thức fetchBrandCategory từ BrandManager với categoryId mới
                                      context
                                          .read<BrandManager>()
                                          .fetchBrandCategory(
                                              selectedIndex + 1);
                                    });
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text("Không có danh mục nào!"),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: Consumer<BrandManager>(
                            builder: (context, brandManager, child) {
                              if (brandManager.itemBrand.isNotEmpty) {
                                // Tạo danh sách DropdownMenuItem cho các thương hiệu
                                lengthBrand =
                                    lengthBrand + brandManager.itemBrand.length;
                                List<DropdownMenuItem<int>> dropdownItems = [];
                                for (int i = 0;
                                    i < brandManager.itemBrand.length;
                                    i++) {
                                  BrandModel brand = brandManager.itemBrand[i];
                                  dropdownItems.add(
                                    DropdownMenuItem(
                                      value: i,
                                      child: Text(
                                        brand.name,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                }
                                return DropdownButton<int>(
                                  value: _selectedBrand,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor:
                                      const Color.fromARGB(255, 233, 221, 221),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  items: dropdownItems,
                                  onChanged: (int? selectedIndex) {
                                    setState(() {
                                      _selectedItem = brandManager
                                          .itemBrand[selectedIndex!].name;
                                      _selectedBrand =
                                          selectedIndex; // Thay đổi giá trị _selectedBrand thành chỉ số được chọn
                                      _selectedIndexBrand = brandManager
                                          .itemBrand[selectedIndex]
                                          .id; // Lấy ID của thương hiệu được chọn
                                    });
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text("Không có nhãn hiệu nào!"),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 236, 67, 67)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _color,
                        decoration: const InputDecoration(
                          labelText: "Nhập tên màu",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Tên màu không được trống";
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            _showColorPickerDialog(context);
                          },
                          child: const Text(
                            'Chọn màu',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ColorDisplay(color: _selectedColor),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Thông tin chi tiết",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 237, 123, 123)
                                          .withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(3, 4))
                            ],
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Material(
                                elevation: 10,
                                shadowColor:
                                    const Color.fromARGB(255, 236, 67, 67)
                                        .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _memory,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Bộ nhớ'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Bộ nhớ không được trống";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Material(
                                elevation: 10,
                                shadowColor:
                                    const Color.fromARGB(255, 236, 67, 67)
                                        .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _price,
                                  decoration: const InputDecoration(
                                    labelText: 'Giá',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Giá không được trống";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Material(
                                elevation: 10,
                                shadowColor:
                                    const Color.fromARGB(255, 236, 67, 67)
                                        .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _quantity,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Số lượng'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Số lượng không được trống";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                imageFiles!.clear();
                                imageData.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                side: const BorderSide(color: Colors.black)),
                            child: const Text(
                              'Xóa ảnh',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: choiceImage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'Chọn ảnh',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (imageFiles!.isNotEmpty) ...[
                      GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          min(imageFiles!.length, 10),
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: showImage(imageFiles![index]),
                            );
                          },
                        ),
                      ),
                    ],
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 253, 46)),
                      onPressed: () {
                        List<String> splitMemory = _memory.text.split(' ');
                        memory.addAll(splitMemory);
                        List<String> splitPrice = _price.text.split(' ');
                        price.addAll(splitPrice);
                        List<String> splitQuantity = _quantity.text.split(' ');
                        quantity.addAll(splitQuantity);

                        ProductModel product = ProductModel(
                          productName: _name.text,
                          brand: (_selectedIndexBrand).toString(),
                        );
                        ColorsModel color = ColorsModel(
                            name: _selectedColorName, nameVn: _color.text);
                        ProductDetailModel productDetail = ProductDetailModel(
                          memoryOptions: memory,
                          priceOptions: price,
                          quantityOptions: quantity,
                        );

                        if (memory.length != price.length ||
                            price.length != quantity.length ||
                            quantity.length != memory.length) {
                          Fluttertoast.showToast(
                              msg:
                                  "Thông tin về bộ nhớ, giá, số lượng không hợp lệ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 0, 0));
                        } else {
                          _submit(product, color, productDetail, imageData);
                        }
                      },
                      child: const Text(
                        "LƯU",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
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

  choiceImage() async {
    var pickerimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerimage != null) {
      setState(() {
        imageFile = File(pickerimage.path);
        imageFiles!.add(imageFile!);
      });
      imageData.add(base64Encode(imageFile!.readAsBytesSync()));

      return imageData;
    } else {
      return null;
    }
  }

  showImage(File image) {
    return Image.file(
      image,
      width: 400,
      height: 400,
    );
  }
}

class ColorDisplay extends StatelessWidget {
  final Color color;

  const ColorDisplay({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          color: color,
        ),
        width: 70,
        height: 70,
        child: Center(
          child: Text(
            getColorName(color),
            style: TextStyle(
              color: _getTextColor(color),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getTextColor(Color color) {
    // Chọn màu chữ dựa trên độ sáng của màu nền
    if (color.computeLuminance() > 0.5) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
