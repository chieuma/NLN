import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/admin/ui/product/product_detail_screen.dart';
import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/product/phone_detail_screen.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String name;
  const SearchScreen({required this.name, super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<ProductModel>> _fetchSearch;
  bool isSearchComplete = false;
  @override
  void initState() {
    super.initState();
    _fetchSearch = context.read<ProductManager>().fetchPhoneSearch(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông Tin Tìm Kiếm",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _fetchSearch,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if ((snapshot.data as List<ProductModel>).isNotEmpty) {
                    return Phone(fetchPhone: snapshot.data!);
                  }
                  return const NoItem();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Phone extends StatelessWidget {
  final List<ProductModel> fetchPhone;
  const Phone({
    required this.fetchPhone,
    super.key,
  });

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 0.7,
          ),
          itemCount: fetchPhone.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 230, 230),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color.fromARGB(255, 201, 196, 196))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            String role = context.read<LoginService>().userRole;
                            role == 'client'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhoneDetailScreen(
                                        productId: fetchPhone[index].productId!,
                                      ),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreenAdmin(
                                        productId: fetchPhone[index].productId!,
                                      ),
                                    ),
                                  );
                          },
                          child: Image.memory(
                            Uint8List.view(fetchPhone[index]
                                .imageUrls![0]
                                .buffer), // Chuyển từ Uint16List sang Uint8List
                            fit: BoxFit.cover,
                            width: 160,
                            height: 160,
                          )),
                      Text(
                        fetchPhone[index].productName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var color in fetchPhone[index].colorName!)
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                width: 20,
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: getColorFromString(color),
                                  // shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var gb in fetchPhone[index].memoryOptions!)
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '${gb}GB',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Giá từ ${_formatPrice(fetchPhone[index].priceOptions![0])}₫',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PhoneDetailScreenAdmin {}

class NoItem extends StatelessWidget {
  const NoItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black,
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Không tìm thấy sản phẩm nào",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
