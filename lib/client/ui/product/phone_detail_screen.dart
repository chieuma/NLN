import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/favorite.dart';
import 'package:mobile_app_3/client/models/order_1item.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:mobile_app_3/client/ui/cart/cart_manager.dart';
import 'package:mobile_app_3/client/ui/favorite/favorite_manager.dart';
import 'package:mobile_app_3/client/ui/order/payment_1item_screen.dart';
import 'package:mobile_app_3/client/ui/product/comment/all_comment_screen.dart';
import 'package:mobile_app_3/client/ui/product/comment/comment_forrm.dart';
import 'package:mobile_app_3/client/ui/product/comment/comment_manager.dart';
import 'package:mobile_app_3/client/ui/product/comment/comment_screen.dart';
import 'package:mobile_app_3/client/ui/product/config/config_manager.dart';
import 'package:mobile_app_3/client/ui/product/config/config_screen.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:mobile_app_3/client/ui/shared/input_quantity.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:mobile_app_3/client/ui/shared/top_right_badge.dart';
import 'package:provider/provider.dart';

class PhoneDetailScreen extends StatefulWidget {
  final int productId;

  const PhoneDetailScreen({required this.productId, Key? key})
      : super(key: key);

  @override
  State<PhoneDetailScreen> createState() => _PhoneDetailScreenState();
}

class _PhoneDetailScreenState extends State<PhoneDetailScreen> {
  late Future<List<FavoriteModel>> _fetchFav;
  final GlobalKey<InputQtyState> _inputQtyKey = GlobalKey<InputQtyState>();

  int selectedColorIndex = 0;
  int selectedGBIndex = 0;

  PageController pageController = PageController(initialPage: 0);
  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailManager>().fetchPhoneDetail(widget.productId);
    context.read<ConfigManager>().fetchConfig(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductDetailManager>(
          builder: (context, productModel, child) {
            if (productModel.product.isNotEmpty) {
              // Lấy sản phẩm đầu tiên trong danh sách sản phẩm
              ProductDetailModel product = productModel.product.first;
              return Column(
                children: [
                  Text(
                    product.productName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return const Text(
                  'Loading...'); // Hiển thị loading nếu dữ liệu chưa sẵn sàng
            }
          },
        ),
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
        actions: [
          Consumer<FavoriteManager>(
            builder: (context, favoriteManager, child) {
              bool isFavorite = false;
              for (FavoriteModel favorite in favoriteManager.favorite) {
                if (favorite.favPdId == widget.productId) {
                  isFavorite = true;
                  break;
                }
              }
              return GestureDetector(
                onTap: () {
                  if (isFavorite) {
                    // print('remove');
                    context.read<FavoriteManager>().removeFavorite(
                          context.read<LoginService>().userId,
                          widget.productId,
                        );
                  } else {
                    // print('add');
                    context.read<FavoriteManager>().addFavorite(
                          context.read<LoginService>().userId,
                          widget.productId,
                        );
                  }
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black,
                ),
              );
            },
          ),
          Consumer<CartManager>(builder: (context, value, child) {
            return TopRightBadge(
              data: value.countItem(),
              child: IconButton(
                onPressed: () {
                  bottomNavigationModel.setSelectedIndex(3);
                },
                icon: const Icon(
                  Icons.shopping_bag,
                  color: Color.fromARGB(255, 255, 0, 204),
                ),
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<ProductDetailManager>(
          builder: (context, productModel, child) {
            if (productModel.product.isNotEmpty) {
              // Lấy sản phẩm đầu tiên trong danh sách sản phẩm
              ProductDetailModel product =
                  productModel.product[selectedColorIndex];
              List<String> memoryOptions = product.memoryOptions;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 10, 10),
                    child: SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: product.imageUrls!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image(
                                  image: MemoryImage(product.imageUrls![index]),
                                  fit: BoxFit.contain,
                                  width: 250,
                                  height: 200,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 20,
                            top: 100,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 67, 67, 67),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Navigate to the previous image
                                  if (pageController.page != null &&
                                      pageController.page! > 0) {
                                    pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 100,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 67, 67, 67),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  // Navigate to the next image
                                  if (pageController.page != null &&
                                      pageController.page! <
                                          product.imageUrls!.length - 1) {
                                    pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${product.productName} ${product.colorNameVn} ${product.memoryOptions[selectedGBIndex]}GB',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Hiển thị màu sắc
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productModel.product.length,
                      itemBuilder: (context, index) {
                        final ProductDetailModel product =
                            productModel.product[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                              selectedGBIndex =
                                  0; // Reset lại index của GB khi chọn màu mới
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedColorIndex == index
                                      ? Colors.black
                                      : const Color.fromARGB(0, 250, 250, 250),
                                  width: 3, // Độ rộng của viền
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor:
                                    getColorFromString(product.colorName!),
                                radius: 15,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // // Hiển thị dung lượng GB tương ứng với màu sắc đã chọn
                  Row(
                    children: memoryOptions
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedGBIndex = entry.key;
                                });
                              },
                              style: TextButton.styleFrom(
                                side: BorderSide(
                                  color: entry.key == selectedGBIndex
                                      ? Colors.blue
                                      : Colors.black,
                                  // Màu đen khi không được chọn
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                              child: Text(
                                '${entry.value}GB',
                                style: TextStyle(
                                    color: selectedGBIndex == entry.key
                                        ? Colors.blue
                                        : Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              _formatPrice(
                                  product.priceOptions[selectedGBIndex]),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 0, 0, 6),
                              child: Text(
                                '₫',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        int.parse(product.quantityOptions[selectedGBIndex]) > 0
                            ? Text(
                                'Kho: ${product.quantityOptions[selectedGBIndex]}'
                                    .toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 44, 44, 44),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Kho: Hết hàng'.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 44, 44, 44),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputQty(
                          key: _inputQtyKey,
                          initVal: 1,
                          maxVal: int.parse(
                              product.quantityOptions[selectedGBIndex]),
                          minVal: 1,
                          steps: 1,
                        ),
                        TextButton(
                          onPressed: () {
                            int value = _inputQtyKey.currentState!.getValue();
                            context.read<CartManager>().addItemToCart(
                                context.read<LoginService>().userId,
                                int.parse(product.opt![selectedGBIndex]),
                                value);

                            // ScaffoldMessenger.of(context)
                            //   ..hideCurrentSnackBar()
                            //   ..showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //         'Đã thêm sản phẩm vào giỏ hàng',
                            //         textAlign: TextAlign.center,
                            //       ),
                            //     ),
                            //   );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Thêm vào giỏ hàng',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      child: int.parse(
                                  product.quantityOptions[selectedGBIndex]) >
                              0
                          ? TextButton(
                              onPressed: () {
                                int value =
                                    _inputQtyKey.currentState!.getValue();
                                print(product.opt![selectedGBIndex]);
                                final Order1ItemModel order1item =
                                    Order1ItemModel(
                                  productId: product.productId!,
                                  name: product.productName!,
                                  // thêm 1 order mới vào
                                  imageUrl: product.imageUrls![0],
                                  colorVn: product.colorNameVn!,
                                  memory: int.parse(product
                                      .memoryOptions[selectedGBIndex]
                                      .toString()),
                                  price: int.parse(product
                                      .priceOptions[selectedGBIndex]
                                      .toString()),
                                  quantity: value,
                                  optId: int.parse(
                                      product.opt![selectedGBIndex].toString()),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Payment1ItemScreen(
                                      payment1item: order1item,
                                    ),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.orange)),
                              child: const Text(
                                'Mua Ngay',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                showErrorDialog(context, "Sản phẩm hết hàng");
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.orange)),
                              child: const Text(
                                'Vui lòng chờ nhập hàng',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gọi đặt mua ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '0369 951 760 ',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '(7:30 - 23:00)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    color: const Color.fromARGB(255, 216, 214, 214),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(
                                0.2), // Cột thứ nhất chiếm 1 phần
                            1: FlexColumnWidth(1.8), // Cột thứ hai chiếm 2 phần
                          },
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Icon(
                                    Icons.settings_backup_restore,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    'Hư gì đổi nấy trong vòng 12 tháng tại các trung tâm siêu thị toàn quốc',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Icon(
                                    Icons.security,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    'Bảo hành chính hãng điện thoại 1 năm tại trung tâm bảo hành chính hãng',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    color: const Color.fromARGB(255, 216, 214, 214),
                  ),
                  ConfigScreen(productId: widget.productId),
                  Container(
                    height: 8,
                    color: const Color.fromARGB(255, 216, 214, 214),
                  ),
                  CommentScreen(pdId: widget.productId),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(115, 11, 56, 237),
                          spreadRadius: 4,
                          blurRadius: 50,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllCommentScreen()));
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Đặt bán kính là zero để tắt radius
                                    side: const BorderSide(
                                      color: Color.fromARGB(
                                          255, 0, 0, 0), // Màu đường viền
                                      width: 1.0, // Độ dày của đường viền
                                    ),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<CommentManager>(
                                    builder: (context, value, child) {
                                      if (value.listComment.isNotEmpty) {
                                        return Text(
                                          'Xem ${context.read<CommentManager>().listCommentCount.toString()} đánh giá',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        );
                                      } else {
                                        return Center(
                                          child: Text(value.listCommentCount
                                              .toString()),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CommentForm(
                                            productId: widget.productId)));
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 6, 112, 200)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Viết đánh giá',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}
