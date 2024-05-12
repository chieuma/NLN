import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_3/admin/ui/product/addProduct.dart';
import 'package:mobile_app_3/admin/ui/product/product_detail_screen.dart';

import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:mobile_app_3/client/ui/shared/BuildSearchField.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/client/ui/shop/category_manager.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
                  "Danh Sách Sản Phẩm",
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
                    Padding(
                      padding: const EdgeInsets.only(right: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<ProductManager>().fetchPhone();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 35,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              side: const BorderSide(
                                  width: 0.8, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddProductScreen()));
                            },
                            child: const Text(
                              "Thêm sản phẩm mới",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 208, 206, 206),
                      ),
                    ),
                    const CategoryScreen(),
                    const Phone(),
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

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
  });
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryManager>().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryManager>(
      builder: (context, categoryManager, child) {
        if (categoryManager.itemCategory.isNotEmpty) {
          return SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryManager.itemCategory.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 242, 167, 16),
                      ),
                      width: 150.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const PhoneScreen()));
                          },
                          child: Text(
                            categoryManager.itemCategory[index].name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Phone extends StatefulWidget {
  const Phone({
    super.key,
  });

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  void initState() {
    super.initState();
    context.read<ProductManager>().fetchPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductManager>(builder: (context, productManager, child) {
      if (productManager.product.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SizedBox(
            height: 580,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 6,
                crossAxisSpacing: 5,
                childAspectRatio: 0.7,
              ),
              itemCount: productManager.product.length,
              itemBuilder: (context, index) {
                ProductModel product = productManager.product[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black87,
                      title: Text(
                        product.productName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreenAdmin(
                              productId: product.productId!,
                            ),
                          ),
                        );
                      },
                      child: Image.memory(product.imageUrls![0],
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Không có sản phẩm nào",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  ScrollController _scrollController = ScrollController();

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * 100.0, // Change 100.0 to the height of your item
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Scroll Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _scrollToIndex(5); // Scroll to index 5 when button is clicked
            },
            child: Text('Scroll to Index 5'),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
