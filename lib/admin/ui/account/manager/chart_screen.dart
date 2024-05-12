import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/models/brand.dart';
import 'package:mobile_app_3/client/models/category.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shop/brand_manager.dart';
import 'package:mobile_app_3/client/ui/shop/category_manager.dart';
import 'package:provider/provider.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  bool success = false;
  final Map<CategoryModel, int> count = {};
  int _selectedCategoryId = 0;
  List<Color> colors = [
    Colors.purple,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biểu Đồ Thống Kê', style: GoogleFonts.aBeeZee()),
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 158, 137),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Biểu đồ thống kê số sản phẩm thuộc loại",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer2<CategoryManager, ProductManager>(
                  builder: (context, categoryManager, productManager, child) {
                    if (categoryManager.itemCategory.isNotEmpty &&
                        productManager.product.isNotEmpty) {
                      // Tạo một map để lưu trữ số lượng sản phẩm của từng danh mục

                      categoryManager.itemCategory.forEach((category) {
                        count[category] = 0;
                      });
                      // Duyệt qua tất cả sản phẩm
                      for (int i = 0; i < productManager.product.length; i++) {
                        int productId = productManager.product[i].categoryId!;
                        int productCategoryId =
                            productManager.product[i].categoryId!;

                        // Tìm danh mục của sản  phẩm trong danh sách danh mục
                        CategoryModel category =
                            categoryManager.itemCategory.firstWhere(
                          (category) => category.id == productCategoryId,
                        );

                        // Nếu danh mục được tìm thấy, tăng biến đếm cho danh mục đó
                        if (category != null) {
                          count[category] = (count[category] ?? 0) + 1;
                        }
                      }
                      // print(1.toString());
                      // count.forEach((category, productCount) {
                      //   print('${category.name}: $productCount');
                      // });

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 300,
                              child: PieChart(
                                PieChartData(
                                  sections: count.entries.map(
                                    (entry) {
                                      int index = count.keys
                                          .toList()
                                          .indexOf(entry.key);
                                      return PieChartSectionData(
                                        value: entry.value.toDouble(),
                                        title:
                                            '${entry.key.name} \n ${entry.value}',
                                        showTitle: true,
                                        radius: 70,
                                        color: colors[index %
                                            colors
                                                .length], // Sử dụng màu từ danh sách màu
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     for (var entry in count.entries)
                            //       if (entry.value.toInt() <= 5)
                            //         Text.rich(
                            //           TextSpan(
                            //             children: [
                            //               TextSpan(
                            //                 text:
                            //                     ' - ${entry.key.name} đang còn có ',
                            //                 style: const TextStyle(
                            //                     color: Colors.black,
                            //                     fontSize:
                            //                         18), // Màu của phần văn bản này là đen
                            //               ),
                            //               TextSpan(
                            //                 text: entry.value.toString(),
                            //                 style: const TextStyle(
                            //                     color: Colors.red,
                            //                     fontSize: 20,
                            //                     fontWeight: FontWeight
                            //                         .bold), // Màu của phần văn bản này là đỏ
                            //               ),
                            //               const TextSpan(
                            //                 text: ' vui lòng nhập thêm',
                            //                 style: TextStyle(
                            //                     color: Colors.black,
                            //                     fontSize:
                            //                         18), // Màu của phần văn bản này là đen
                            //               ),
                            //             ],
                            //           ),
                            //         )
                            //   ],
                            // )
                          ],
                        ),
                      );
                    } else {
                      return Text('Danh sách danh mục hoặc sản phẩm rỗng.');
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 158, 137),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Biểu đồ thống kê số sản phẩm thuộc \nnhãn hiệu",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer<CategoryManager>(
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
                Consumer2<BrandManager, ProductManager>(
                  builder: (context, brandManager, productManager, child) {
                    // Tạo một map để lưu trữ số lượng sản phẩm của từng nhãn hiệu
                    Map<BrandModel, int> brandProductCount = {};

                    if (brandManager.itemBrand.isNotEmpty) {
                      // Khởi tạo số lượng sản phẩm của mỗi nhãn hiệu là 0
                      brandManager.itemBrand.forEach((brand) {
                        brandProductCount[brand] = 0;
                      });

                      // Duyệt qua tất cả sản phẩm
                      for (int i = 0; i < productManager.product.length; i++) {
                        int productId = productManager.product[i].productId!;
                        String productBrand = productManager.product[i].brand;

                        // Tìm nhãn hiệu của sản phẩm trong danh sách nhãn hiệu
                        BrandModel brand = brandManager.itemBrand.firstWhere(
                          (brand) => brand.name == productBrand,
                          orElse: () =>
                              BrandModel(id: -1, name: '', categoryId: -1),
                        );

                        // Nếu nhãn hiệu được tìm thấy, tăng biến đếm cho nhãn hiệu đó
                        if (brand.id != -1) {
                          brandProductCount[brand] =
                              (brandProductCount[brand] ?? 0) + 1;
                        }
                      }

                      // Hiển thị thông tin về số lượng sản phẩm của từng nhãn hiệu
                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: PieChart(
                                    PieChartData(
                                      sections: brandProductCount.entries.map(
                                        (entry) {
                                          int index = brandProductCount.keys
                                              .toList()
                                              .indexOf(entry.key);
                                          return PieChartSectionData(
                                            value: entry.value.toDouble(),
                                            title:
                                                '${entry.key.name} \n ${entry.value}',
                                            showTitle: true,
                                            radius: 70,
                                            color: colors[index %
                                                colors
                                                    .length], // Sử dụng màu từ danh sách màu
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     for (var entry in brandProductCount.entries)
                                //       if (entry.value.toInt() <= 5)
                                //         Text.rich(
                                //           TextSpan(
                                //             children: [
                                //               TextSpan(
                                //                 text:
                                //                     ' - ${entry.key.name} đang còn có ',
                                //                 style: const TextStyle(
                                //                     color: Colors.black,
                                //                     fontSize:
                                //                         18), // Màu của phần văn bản này là đen
                                //               ),
                                //               TextSpan(
                                //                 text: entry.value.toString(),
                                //                 style: const TextStyle(
                                //                     color: Colors.red,
                                //                     fontSize: 20,
                                //                     fontWeight: FontWeight
                                //                         .bold), // Màu của phần văn bản này là đỏ
                                //               ),
                                //               const TextSpan(
                                //                 text: ' vui lòng nhập thêm',
                                //                 style: TextStyle(
                                //                     color: Colors.black,
                                //                     fontSize:
                                //                         18), // Màu của phần văn bản này là đen
                                //               ),
                                //             ],
                                //           ),
                                //         )
                                //   ],
                                // )
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Không có nhãn hiệu nào!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }
                  },
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
