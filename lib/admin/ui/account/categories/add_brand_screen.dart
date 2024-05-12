import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/models/category.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/client/ui/shop/brand_manager.dart';
import 'package:mobile_app_3/client/ui/shop/category_manager.dart';
import 'package:provider/provider.dart';

class AddBrandScreen extends StatefulWidget {
  const AddBrandScreen({super.key});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  final TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  int _selectedCategoryId = 0;

  int _selectedBrand = 0;
  int _selectedIndexBrand = 0;
  String _selectedItem = '';

  int _selectedPromotion = 0;
  int id = 0;
  int lengthBrand = 0;
  @override
  void initState() {
    super.initState();
    context.read<CategoryManager>().fetchCategory();
  }

  Future<void> _submit(int id, String name) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool success = await context.read<BrandManager>().addBrand(id, name);

      if (!success) {
        await showErrorDialog(context, 'Thêm không thành công');
      } else {
        await showSuccessDialog(context, 'Thêm nhãn hiệu thành công');
        setState(() {
          _name.text = '';
        });
      }
    } catch (error) {
      await showErrorDialog(context, "Lỗi không thêm được nhãn hiệu sản phẩm");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm nhãn hiệu",
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
            Consumer<CategoryManager>(
              builder: (context, value, child) {
                if (value.itemCategory.isNotEmpty) {
                  List<DropdownMenuItem<int>> dropdownItems = [];
                  for (int i = 0; i < value.itemCategory.length; i++) {
                    CategoryModel categoryModel = value.itemCategory[i];
                    // condition = promotion.condition;
                    // discount = promotion.discount;
                    dropdownItems.add(
                      DropdownMenuItem(
                        value: i,
                        child: Text(categoryModel.name),
                      ),
                    );
                  }
                  return DropdownButton<int>(
                    value: _selectedPromotion,
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: const Color.fromARGB(255, 233, 221, 221),
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
                        _selectedPromotion = selectedIndex!;
                        CategoryModel selectedPromotion =
                            value.itemCategory[selectedIndex];

                        // Cập nhật giá trị discount và condition với thông tin mới từ promotion được chọn
                        id = selectedPromotion.id;
                        // condition = selectedPromotion.condition;
                        // _totalPrice(widget.payment1item.quantity,
                        //     widget.payment1item.price, discount, condition);
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Material(
                  elevation: 10,
                  shadowColor:
                      const Color.fromARGB(255, 0, 211, 109).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: "Nhập tên nhãn hiệu",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Tên nhãn hiệu không được trống";
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  //  print(id);
                  _submit(id, _name.text);
                },
                child: const Text(
                  "Thêm",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
