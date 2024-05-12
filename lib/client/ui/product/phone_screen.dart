import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/brand.dart';
import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/ui/product/phone_detail_screen.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/BuildSearchField.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:mobile_app_3/client/ui/shop/brand_manager.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatefulWidget {
  final int categoryId;
  const PhoneScreen({required this.categoryId, super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  late Future<List<BrandModel>> _fetchBrandCategory;

  late Future<List<ProductModel>> _fetchProductCategory;
  bool selectAll = true;
  @override
  void initState() {
    super.initState();

    _fetchProductCategory =
        context.read<ProductManager>().fetchProductCategory(widget.categoryId);
    _fetchBrandCategory =
        context.read<BrandManager>().fetchBrandCategory(widget.categoryId);
    context.read<ProductManager>().filterBrand('');
    setState(() {
      selectAll = true;
    });
  }

  void updateFilteredProducts(String name) {
    context.read<ProductManager>().filterBrand(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh Sách Các Sản Phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuildSearchField(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Filter()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(66, 246, 246, 246)),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                          width: 1.2,
                        ),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // Tắt radius
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Text(
                          'Lọc',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectAll = !selectAll;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: selectAll == true
                          ? MaterialStateProperty.all(
                              Color.fromARGB(255, 255, 162, 0))
                          : MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                          width: 1.2,
                        ),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shower,
                            color: selectAll == true
                                ? Colors.white
                                : Color.fromARGB(255, 255, 140, 0)),
                        const Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color.fromARGB(183, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _fetchBrandCategory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return PhoneBrand(
                      fetchBrand: snapshot.data!,
                      onBrandSelected: updateFilteredProducts,
                    );
                  } else {
                    return Text('Không có dữ liệu về thương hiệu.');
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Consumer<ProductManager>(
              builder: (context, productManager, child) {
                if (selectAll) {
                  return Phone(fetchPhone: productManager.productCategory);
                } else if (productManager.productBrand.isNotEmpty) {
                  return Phone(fetchPhone: productManager.productBrand);
                } else {
                  return Padding(
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
                              "Hiện tại không có sản phẩm nào",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class PhoneBrand extends StatefulWidget {
  final List<BrandModel> fetchBrand;
  final Function(String name) onBrandSelected;
  PhoneBrand(
      {required this.fetchBrand, required this.onBrandSelected, super.key});

  @override
  State<PhoneBrand> createState() => _PhoneBrandState();
}

class _PhoneBrandState extends State<PhoneBrand> {
  late Future<List<ProductModel>> _fetchPhone;
  int selectAll = -1;
  @override
  void initState() {
    super.initState();
    _fetchPhone = context.read<ProductManager>().fetchPhone();
    selectAll = 0;
    widget.onBrandSelected(widget.fetchBrand.first.name);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.fetchBrand.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectAll = index;
                });
                widget.onBrandSelected(widget.fetchBrand[selectAll].name);
              },
              style: ButtonStyle(
                backgroundColor: selectAll == index
                    ? MaterialStateProperty.all(Colors.black)
                    : MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(
                    color: Color.fromARGB(255, 52, 51, 51),
                    width: 1.2,
                  ),
                ),
              ),
              child: Text(
                widget.fetchBrand[index].name,
                style: TextStyle(
                    color: selectAll == index ? Colors.white : Colors.black),
              ),
            ),
          );
        },
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
    return SizedBox(
      //  height: 700,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                  color: const Color.fromARGB(255, 241, 224, 224),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 211, 85, 85))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneDetailScreen(
                              productId: fetchPhone[index].productId!,
                            ),
                          ),
                        );
                      },
                      child: Image(
                        image: MemoryImage(fetchPhone[index].imageUrls![0]),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
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
                              margin: const EdgeInsets.symmetric(horizontal: 2),
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
    );
  }
}
