import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:provider/provider.dart';

class NotfiyScreen extends StatefulWidget {
  const NotfiyScreen({Key? key}) : super(key: key);

  @override
  State<NotfiyScreen> createState() => _NotfiyScreenState();
}

class _NotfiyScreenState extends State<NotfiyScreen> {
  List<ProductDetailModel> product = [];
  final TextEditingController _quantity = TextEditingController();

  int quantity = 20;
  bool test = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Gọi hàm fetch dữ liệu khi widget được khởi tạo
  }

  Future<void> _fetchProducts() async {
    final productManager = context.read<ProductManager>();
    await productManager.fetchPhone(); // Gọi hàm fetchPhone của ProductManager
    final productIds =
        productManager.product.map((product) => product.productId).toList();

    final productDetailManager = context.read<ProductDetailManager>();
    for (final productId in productIds) {
      final products = await productDetailManager.fetchPhoneDetail(productId!);
      setState(() {
        product.addAll(products);
      });
    }
    print(product.length);
  }

  @override
  Widget build(BuildContext context) {
    if (product.isNotEmpty) {
      for (var item in product) {
        for (int i = 0; i < item.opt!.length; i++) {
          //  Text(item.opt![i]),
          if (test && int.parse(item.quantityOptions[i]) < quantity ||
              !test && int.parse(item.quantityOptions[i]) > quantity) {
            count++;
          }
        }
      }
      //print(count);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông báo",
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
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
              child: TextFormField(
                controller: _quantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Nhập số để kiểm tra",
                    border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: test ? Colors.black : Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                    onPressed: () {
                      setState(() {
                        quantity = int.parse(_quantity.text);
                        test = !test;
                        count = 0;
                      });
                    },
                    child: Text(
                      "Kiểm tra nhỏ hơn",
                      style:
                          TextStyle(color: test ? Colors.white : Colors.black),
                    )),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: test ? Colors.white : Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                    onPressed: () {
                      setState(() {
                        quantity = int.parse(_quantity.text);
                        test = !test;
                        count = 0;
                      });
                    },
                    child: Text(
                      "Kiểm tra lớn hơn",
                      style: TextStyle(
                          color: test
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : const Color.fromARGB(255, 255, 255, 255)),
                    )),
              ],
            ),
            if (product.isNotEmpty)
              Column(
                children: [
                  for (var item in product)
                    for (int i = 0; i < item.opt!.length; i++)
                      //  Text(item.opt![i]),
                      if (test &&
                              int.parse(item.quantityOptions[i]) < quantity ||
                          !test &&
                              int.parse(item.quantityOptions[i]) > quantity)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.memory(
                                        item.imageUrls!.first,
                                        width: 200,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(item.productName!),
                                      Text("${item.memoryOptions[i]} GB"),
                                      Text("Màu: ${item.colorNameVn!}"),
                                      Text(
                                          "Số lượng: ${item.quantityOptions[i]}"),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                  if (count == 0)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Không tồn tại sản phẩm",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            if (product.isEmpty)
              const Center(
                child: Text(
                  "Không tồn tại sản phẩm",
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
