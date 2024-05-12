import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/admin/ui/account/categories/add_brand_screen.dart';
import 'package:mobile_app_3/admin/ui/account/categories/add_category_screen.dart';
import 'package:mobile_app_3/client/models/category.dart';
import 'package:mobile_app_3/client/ui/shop/brand_manager.dart';
import 'package:mobile_app_3/client/ui/shop/category_manager.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool selectedIndex = true;
  @override
  void initState() {
    super.initState();
    selectedIndex = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quản lý danh mục",
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                context.read<CategoryManager>().fetchCategory();
                context.read<BrandManager>().fetchBrand();
              },
              icon: const Icon(Icons.refresh),
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 165,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex
                            ? const Color.fromARGB(255, 187, 1, 255)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: BorderSide(
                            color: selectedIndex ? Colors.white : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = !selectedIndex;
                        });
                      },
                      child: Text(
                        "Loại sản phẩm",
                        style: TextStyle(
                          color: selectedIndex ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 165,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex
                              ? Colors.white
                              : const Color.fromARGB(255, 187, 1, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          side: BorderSide(
                              color:
                                  selectedIndex ? Colors.black : Colors.white)),
                      onPressed: () {
                        setState(() {
                          selectedIndex = !selectedIndex;
                        });
                      },
                      child: Text(
                        "Nhãn hiệu",
                        style: TextStyle(
                          color: selectedIndex ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            selectedIndex ? const Category() : const Brand()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectedIndex
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCategoryScreen()))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddBrandScreen()));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool success = false;
  @override
  void initialState() {
    super.initState();
    context.read<CategoryManager>().fetchCategory();
  }

  Future<void> _removeOne(int id) async {
    // Sau khi xóa, gọi lại hàm fetchData để cập nhật giao diện
    success = await context.read<CategoryManager>().removeCategory(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CategoryManager>(builder: (context, value, child) {
          if (value.itemCategory.isNotEmpty) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.itemCategory.length,
                itemBuilder: (context, index) {
                  CategoryModel categoryModel = value.itemCategory[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Bạn có chắn chắn xóa loại sản phẩm này không?',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              content: const Icon(
                                Icons.warning,
                                color: Colors.red,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Hủy'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await _removeOne(categoryModel.id);
                                        Navigator.of(context).pop();
                                        if (success == false) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Lỗi ràng buộc dữ liệu, loại sản phẩm đang được sử dụng",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 243, 154, 0));
                                        }
                                        if (success == true) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Xóa loại sản phẩm thành công",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 243, 154, 0));
                                        }
                                      },
                                      child: const Text('Xác nhận'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 108, 231, 77),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Id",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    categoryModel.id.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Tên loại",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    categoryModel.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Không có loại sản phẩm nào"),
            );
          }
        })
      ],
    );
  }
}

class Brand extends StatefulWidget {
  const Brand({super.key});

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  int _selectedCategoryId = 0;

  int _selectedBrand = 0;
  int _selectedIndexBrand = 0;
  String _selectedItem = '';

  int lengthBrand = 0;

  bool success = false;
  @override
  void initialState() {
    super.initState();
    context.read<BrandManager>().fetchBrand();
  }

  Future<void> _removeOne(int id) async {
    // Sau khi xóa, gọi lại hàm fetchData để cập nhật giao diện
    success = await context.read<BrandManager>().removeBrand(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CategoryManager>(
          builder: (context, categoryManager, child) {
            if (categoryManager.itemCategory.isNotEmpty) {
              List<DropdownMenuItem<int>> dropdownItems = [];
              for (int i = 0; i < categoryManager.itemCategory.length; i++) {
                CategoryModel category = categoryManager.itemCategory[i];
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
                dropdownColor: const Color.fromARGB(255, 209, 200, 200),
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
                        .fetchBrandCategory(selectedIndex + 1);
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
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: Consumer<BrandManager>(
            builder: (context, brandManager, child) {
              if (brandManager.itemBrand.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: brandManager.itemBrand.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Bạn có chắn chắn xóa nhãn hiệu này không?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    content: const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await _removeOne(brandManager
                                                  .itemBrand[index].id);
                                              Navigator.of(context).pop();
                                              if (success == false) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Lỗi ràng buộc dữ liệu, loại sản phẩm đang được sử dụng",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 243, 154, 0));
                                              }
                                              if (success == true) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Xóa loại sản phẩm thành công",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 243, 154, 0));
                                              }
                                            },
                                            child: const Text('Xác nhận'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 0, 0, 0),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      brandManager.itemBrand[index].name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 41, 41, 41),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("Không có nhãn hiệu nào!"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
