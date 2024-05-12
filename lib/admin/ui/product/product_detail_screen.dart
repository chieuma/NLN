import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/admin/ui/product/config/add_config_screen.dart';
import 'package:mobile_app_3/admin/ui/product/config/update_config_screen.dart';
import 'package:mobile_app_3/admin/ui/product/edit_product_screen.dart';
import 'package:mobile_app_3/admin/ui/product/update_productName_screen.dart';
import 'package:mobile_app_3/client/models/config.dart';
import 'package:mobile_app_3/client/ui/product/config/config_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class ProductDetailScreenAdmin extends StatefulWidget {
  final int productId;

  const ProductDetailScreenAdmin({required this.productId, super.key});

  @override
  State<ProductDetailScreenAdmin> createState() =>
      _ProductDetailScreenAdminState();
}

class _ProductDetailScreenAdminState extends State<ProductDetailScreenAdmin> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailManager>().fetchPhoneDetail(widget.productId);
    context.read<ConfigManager>().fetchConfig(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin chi tiết",
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
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProductManager>().fetchPhone();
              context
                  .read<ProductDetailManager>()
                  .fetchPhoneDetail(widget.productId);
            },
            icon: const Icon(
              Icons.refresh,
              size: 35,
              color: Color.fromARGB(255, 0, 106, 255),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GeneralInfo(
              productId: widget.productId,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Divider(
                color: Colors.black,
              ),
            ),
            ColorInfo(productId: widget.productId),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Divider(
                color: Colors.black,
              ),
            ),
            ConfigInfo(productId: widget.productId),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Divider(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralInfo extends StatefulWidget {
  final int productId;
  const GeneralInfo({
    required this.productId,
    super.key,
  });

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ProductDetailManager>(
        builder: (context, productDetailManager, child) {
          if (productDetailManager.product.isNotEmpty) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    //     shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.zero,
                    //     ),
                    //     side: const BorderSide(width: 0.8, color: Colors.black),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AddConfigScreen(
                    //                 productId: widget.productId)));
                    //   },
                    //   child: const Text(
                    //     "Thêm cấu hình",
                    //     style: TextStyle(color: Colors.white, fontSize: 16),
                    //   ),
                    // ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "Thông tin chung",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Divider(
                        color: Color.fromARGB(255, 255, 157, 0),
                        thickness: 2.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Tên: ${productDetailManager.product[0].productName!}',
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Loại: ${productDetailManager.product[0].category!}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Nhãn hiệu: ${productDetailManager.product[0].brand!}',
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProductNameScreen(
                                  productId: widget.productId,
                                  name: productDetailManager
                                      .product[0].productName!,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Cập nhật",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ConfigInfo extends StatelessWidget {
  final int productId;
  const ConfigInfo({
    required this.productId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ConfigManager>(
        builder: (context, configManager, child) {
          if (configManager.config.isNotEmpty) {
            ConfigModel config = configManager.config[0];
            return Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Thông tin cấu hình",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: Divider(
                        color: Color.fromARGB(255, 255, 157, 0),
                        thickness: 2.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 201, 63),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(0.5),
                            1: FlexColumnWidth(1),
                          },
                          children: [
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'Màn hình:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    configManager.config[0].screen!,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Text(
                                    'Chip:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    configManager.config[0].chip!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'RAM:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    "${configManager.config[0].ram!} GB",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'Camera trước:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    '${configManager.config[0].frontCamera!} MP',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Text(
                                    'Camera sau:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "${configManager.config[0].rearCamera!} MP",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'Pin, Sạc:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    "${configManager.config[0].pin!} mAh",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'Jack Tai nghe',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    configManager.config[0].jackPhone!,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'Bluetooth',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    configManager.config[0].bluetooth!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                    child: Text(
                                  'Hệ điều hành:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                                TableCell(
                                  child: Text(
                                    configManager.config[0].opSystem!,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateConfigScreen(config: config),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: const Text(
                            "Cập nhật",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const Text(
                    'Chưa có cấu hình chi tiết',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      side: const BorderSide(width: 0.8, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddConfigScreen(productId: productId)));
                    },
                    child: const Text(
                      "Thêm cấu hình",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ColorInfo extends StatefulWidget {
  final int productId;
  const ColorInfo({required this.productId, super.key});

  @override
  State<ColorInfo> createState() => _ColorInfoState();
}

class _ColorInfoState extends State<ColorInfo> {
  TextEditingController _colorVn = TextEditingController();
  TextEditingController _brandController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailManager>().fetchPhoneDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Thông tin màu sắc và chi tiết",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              SizedBox(
                width: 215,
                child: Divider(
                  color: Color.fromARGB(255, 255, 157, 0),
                  thickness: 2.0,
                ),
              ),
            ],
          ),
          Consumer<ProductDetailManager>(
            builder: (context, product, child) {
              if (product.product.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.product.length,
                  itemBuilder: (context, index) {
                    var color = product.product[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProductScreen(
                                          productId: widget.productId,
                                          product: color),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: const SizedBox(
                                  width: 60,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Color.fromARGB(255, 7, 222, 255),
                                      ),
                                      Text(
                                        " Sửa",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  print(product.product.length);
                                  showConfirmDelete(
                                      context,
                                      "Bạn có chắc chắn muốn xóa?",
                                      color,
                                      product.product.length,
                                      widget.productId);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 51, 0, 255))),
                                child: const SizedBox(
                                  width: 60,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.close,
                                        color: Color.fromARGB(255, 255, 2, 2),
                                      ),
                                      Text(
                                        " Xóa",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tên màu tiếng việt',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(color.colorNameVn!)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Màu đã chọn',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: getColorFromString(color.colorName!),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ảnh',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: color.imageUrls!.length,
                                  itemBuilder: (context, indexImage) {
                                    return Column(
                                      children: [
                                        Image.memory(
                                          color.imageUrls![indexImage],
                                          width: 300,
                                          height: 300,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Chi tiết về dung lượng, giá và số lượng trong kho',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          'Giá(VND)',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          'Số lượng',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (int i = 0; i < color.opt!.length; i++)
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Text(color.memoryOptions[i]),
                                        ),
                                        TableCell(
                                          child: Text(color.priceOptions[i]),
                                        ),
                                        TableCell(
                                          child: Text(color.quantityOptions[i]),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: colorEditStatus[color.colorName!]!
                              //       ? ElevatedButton(
                              //           style: ElevatedButton.styleFrom(
                              //             backgroundColor: const Color.fromARGB(
                              //                 255, 104, 253, 109),
                              //           ),
                              //           onPressed: () {
                              //             setState(() {
                              //               colorEditStatus[color.colorName!] =
                              //                   !colorEditStatus[
                              //                       color.colorName!]!;
                              //             });
                              //             _saveChanges();
                              //           },
                              //           child: const Text('Lưu',
                              //               style: TextStyle(
                              //                   color: Color.fromARGB(
                              //                       255, 0, 0, 0))),
                              //         )
                              //       : ElevatedButton(
                              //           style: ElevatedButton.styleFrom(
                              //             backgroundColor: const Color.fromARGB(
                              //                 255, 33, 189, 232),
                              //           ),
                              //           onPressed: () {
                              //             setState(() {
                              //               colorEditStatus[color.colorName!] =
                              //                   !colorEditStatus[
                              //                       color.colorName!]!;
                              //               _colorVn.text = color.colorNameVn!;
                              //             });
                              //           },
                              //           child: const Text('Chỉnh sửa',
                              //               style:
                              //                   TextStyle(color: Colors.white)),
                              //         ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
