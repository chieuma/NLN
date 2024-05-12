import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/ui/product/phone_detail_screen.dart';
import 'package:mobile_app_3/client/ui/product/phone_screen.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/BuildSearchField.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:provider/provider.dart';
import '../shop/category_manager.dart';
import '../../models/category.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<List<CategoryModel>> _fetchCaterogy;
  late Future<List<ProductModel>> _fetchPhone;
  @override
  void initState() {
    super.initState();
    _fetchCaterogy = context.read<CategoryManager>().fetchCategory();
    _fetchPhone = context.read<ProductManager>().fetchPhone();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Shop',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'BebasNeue'),
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 247, 205, 205),
                        Color.fromARGB(255, 219, 154, 231)
                      ],
                    ),
                  ),
                ),
                shadowColor: Colors.black,
                elevation: 4,
                leading: Container(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BuildSearchField()));
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // MyWidget(),
                    SizedBox(
                      height: 50,
                      child: FutureBuilder(
                        future: _fetchCaterogy,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CategoryScreen(
                              fetchCaterogy: snapshot.data!,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage(
                          "assets/image/banner.png",
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 0, 0, 0),
                              Color.fromARGB(255, 239, 168, 27),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Tiện ích và hỗ trợ nhanh',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 0, 255, 94),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Icons.receipt_long,
                                      color: Color.fromARGB(255, 1, 1, 1),
                                    ),
                                  ),
                                  const Text(
                                    'Theo dõi\nđơn hàng',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 0, 248, 174),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Icons.home_repair_service,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const Text(
                                    'Bảo hành,\n bảo dưỡng',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 246, 40, 40),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Icons.warning_amber,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const Text(
                                    'Góp ý\n khiếu nại',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 226, 251, 0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Icons.card_giftcard,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const Text(
                                    'Quà\n của tôi',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 234, 0, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Icons.headphones,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const Text(
                                    'Hỗ trợ\n kỹ thuật',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 255, 217, 0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Icons.cleaning_services,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const Text('Vệ sinh\n thiết bị'),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const CategoriesImage(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 0, 0, 0),
                              Color.fromARGB(255, 239, 168, 27),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Tất cả sản phẩm',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: FutureBuilder(
                        future: _fetchPhone,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Phone(
                                fetchPhone: snapshot.data!,
                              );
                            } else {
                              return const Text(
                                  'No data available'); // Xử lý trường hợp không có dữ liệu
                            }
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Phone extends StatefulWidget {
  final List<ProductModel> fetchPhone;
  const Phone({
    required this.fetchPhone,
    super.key,
  });

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //  physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemCount: widget.fetchPhone.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 225, 225),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: const Color.fromARGB(255, 178, 182, 179),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneDetailScreen(
                          productId: widget.fetchPhone[index].productId!,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image(
                      image:
                          MemoryImage((widget.fetchPhone[index].imageUrls![0])),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                Text(
                  widget.fetchPhone[index].productName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var color in widget.fetchPhone[index].colorName!)
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: getColorFromString(color),
                              // shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var gb in widget.fetchPhone[index].memoryOptions!)
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Giá từ ${_formatPrice(widget.fetchPhone[index].priceOptions![0])}₫',
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// Danh muc san pham
class CategoryScreen extends StatelessWidget {
  final List<CategoryModel> fetchCaterogy;
  const CategoryScreen({
    required this.fetchCaterogy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: fetchCaterogy.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 0, 74, 90),
            ),
            width: 150.0,
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhoneScreen(categoryId: fetchCaterogy[index].id),
                    ),
                  );
                },
                child: Text(
                  fetchCaterogy[index].name,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoriesImage extends StatelessWidget {
  const CategoriesImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 239, 168, 27),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Danh mục sản phẩm',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 71, 92, 79),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        width: 60,
                        child: const Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 28, 221, 34),
                        ),
                      ),
                      const Text(
                        'Điện thoại',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 67, 69, 69),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        width: 60,
                        child: const Icon(
                          Icons.laptop,
                          color: Color.fromARGB(255, 15, 220, 213),
                        ),
                      ),
                      const Text(
                        'Laptop',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 19, 19, 19),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        width: 60,
                        child: const Icon(
                          Icons.headphones,
                          color: Color.fromARGB(255, 202, 5, 5),
                        ),
                      ),
                      const Text(
                        'Tai nghe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 19, 19, 19),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        width: 60,
                        child: const Icon(
                          Icons.keyboard,
                          color: Color.fromARGB(255, 176, 195, 7),
                        ),
                      ),
                      const Text(
                        'Bàn phím',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 67, 69, 69),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 60,
                          width: 60,
                          child: const Icon(
                            Icons.headphones,
                            color: Color.fromARGB(255, 179, 1, 195),
                          ),
                        ),
                        const Text(
                          'Chuột',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 71, 92, 79),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        width: 60,
                        child: const Icon(
                          Icons.usb,
                          color: Color.fromARGB(255, 229, 176, 3),
                        ),
                      ),
                      const Text(
                        'USB',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
