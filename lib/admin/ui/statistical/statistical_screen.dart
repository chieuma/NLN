import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/admin/model/favorite.dart';
import 'package:mobile_app_3/admin/model/statistical.dart';
import 'package:mobile_app_3/admin/ui/statistical/statistical_manager.dart';
import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/models/productsell.dart';

import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:provider/provider.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({super.key});

  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderManager>().fetchAllOrder();
  }

  void dispose() {
    super.dispose();
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Thống kê",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                centerTitle: true,
                shadowColor: Colors.black,
                elevation: 4,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 213, 204, 204),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tổng doanh thu:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${_formatPrice(context.watch<OrderManager>().totalPrice().toString())} VND',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 248, 228, 10),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TOP 10 Khách Hàng Truy Cập Nhiều Nhất",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const TopAccessRanking(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TOP 10 Sản Phẩm Được Yêu Thích Nhất",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Color.fromARGB(255, 234, 10, 85),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const TopFavoriteRanking(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TOP 10 Sản Phẩm Bán Chạy Nhất",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              const Icon(
                                Icons.sell,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const TopSellRanking(),
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

class TopAccessRanking extends StatefulWidget {
  const TopAccessRanking({super.key});

  @override
  State<TopAccessRanking> createState() => _TopAccessRankingState();
}

class _TopAccessRankingState extends State<TopAccessRanking> {
  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchAllUser();
    context.read<StatisticalManager>().fetchStatistical();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer2<StatisticalManager, UserManager>(
          builder: (context, stManager, userManager, child) {
            if (stManager.list.isNotEmpty) {
              int length =
                  stManager.list.length > 10 ? 10 : stManager.list.length;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 25, 209, 4),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: SizedBox(
                    height: length > 10 ? 7 * 90 : length * 90,
                    child: ListView.builder(
                      itemCount: length,
                      itemBuilder: (context, index) {
                        StatisticalModel st = stManager.list[index];
                        //  final UserModel userModel;
                        final UserModel userModel;
                        if (userManager.userAll.isNotEmpty) {
                          userModel = userManager.userAll.firstWhere(
                            (element) => element.id == st.userId,
                          );
                        } else {
                          // Handle the case when userManager.userAll is empty
                          // For example, you can assign a default value to userModel
                          userModel = UserModel(
                              name: 'haha',
                              date: DateTime.now(),
                              password: "000000",
                              role:
                                  "client"); // Assuming UserModel has a default constructor
                        }

                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(0.3),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(0.4),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  color: const Color.fromARGB(
                                                      255, 2, 217, 255),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        (index + 1).toString(),
                                                        style: GoogleFonts
                                                            .bioRhyme(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.only(top: 18),
                                      child: Text(
                                        userModel.name,
                                        style: GoogleFonts.bioRhyme(),
                                      ),
                                    )),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(18),
                                        child: Text(
                                          st.count.toString(),
                                          style: GoogleFonts.bioRhyme(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return const Text("Không có lượt truy cập nào");
            }
          },
        )
      ],
    );
  }
}

class TopFavoriteRanking extends StatefulWidget {
  const TopFavoriteRanking({super.key});

  @override
  State<TopFavoriteRanking> createState() => _TopFavoriteRankingState();
}

class _TopFavoriteRankingState extends State<TopFavoriteRanking> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticalManager>().fetchFavorite();
    context.read<ProductManager>().fetchPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer2<StatisticalManager, ProductManager>(
          builder: (context, stManager, productManager, child) {
            if (stManager.listFavorite.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 175, 225),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: SizedBox(
                    height: (100 * stManager.listFavorite.length).toDouble(),
                    child: ListView.builder(
                      itemCount: stManager.listFavorite.length,
                      itemBuilder: (context, index) {
                        final FavoriteModel st = stManager.listFavorite[index];

                        final ProductModel productModel;
                        if (productManager.product.isNotEmpty) {
                          productModel = productManager.product.firstWhere(
                            (element) => element.productId == st.pdId,
                          );
                        } else {
                          productModel =
                              ProductModel(productName: " ", brand: " ");
                        }

                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(0.3),
                                1: FlexColumnWidth(0.5),
                                2: FlexColumnWidth(0.6),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  color: const Color.fromARGB(
                                                      255, 2, 217, 255),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        (index + 1).toString(),
                                                        style: GoogleFonts
                                                            .bioRhyme(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 18),
                                            child: Text(
                                              productModel.productName,
                                              style: GoogleFonts.bioRhyme(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Text('Số lượt: '),
                                              Text(
                                                st.count.toString(),
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2, right: 2, bottom: 2),
                                        child: Image.memory(
                                          productModel.imageUrls![0],
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 222, 136, 136)),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Không có sản phẩm được yêu thích nào",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}

class TopSellRanking extends StatefulWidget {
  const TopSellRanking({super.key});

  @override
  State<TopSellRanking> createState() => _TopSellRankingState();
}

class _TopSellRankingState extends State<TopSellRanking> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticalManager>().fetchFavorite();
    context.read<ProductManager>().fetchPhone();
    context.read<OrderManager>().fetchAllOrder();
    context.read<OrderManager>().fetchCountAllOrderDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<OrderManager>(
          builder: (context, stManager, child) {
            if (stManager.countOrderList.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 234, 225, 93),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: stManager.countOrderList.length,
                      itemBuilder: (context, index) {
                        final ProductSellModel st =
                            stManager.countOrderList[index];

                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(0.3),
                                1: FlexColumnWidth(0.5),
                                2: FlexColumnWidth(0.6),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  color: const Color.fromARGB(
                                                      255, 2, 217, 255),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        (index + 1).toString(),
                                                        style: GoogleFonts
                                                            .bioRhyme(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 18),
                                            child: Text(
                                              st.name,
                                              style: GoogleFonts.bioRhyme(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text('Màu: ${st.colorVn}'),
                                          Text(
                                            '${st.memory} GB',
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Số lượng: ${st.count}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 112, 134, 0),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.memory(
                                          st.image,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 222, 136, 136)),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Không có sản phẩm được yêu thích nào",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
