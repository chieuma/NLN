import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/cart.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/account/account_screen.dart';
import 'package:mobile_app_3/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:mobile_app_3/client/ui/cart/cart_manager.dart';
import 'package:mobile_app_3/client/ui/order/payment_all_screen.dart';
import 'package:mobile_app_3/client/ui/shared/top_right_badge.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedRadio = '';
  double total = 0;

  @override
  void initState() {
    super.initState();
    int? userId = context.read<LoginService>().userId;
    context
        .read<CartManager>()
        .fetchCart(userId); // Gọi hàm fetchData trong initState
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  Future<void> _removeOneItem(int cartId) async {
    // Sau khi xóa, gọi lại hàm fetchData để cập nhật giao diện
    int? userId = context.read<LoginService>().userId;
    context.read<CartManager>().removeOneItem(cartId, userId);
  }

  Future<void> _removeAllItem() async {
    // Sau khi xóa, gọi lại hàm fetchData để cập nhật giao diện
    int? userId = context.read<LoginService>().userId;
    context.read<CartManager>().removeAllItem(userId);
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
                  'GIỎ HÀNG',
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
                shadowColor: Colors.black,
                elevation: 4,
                actions: [
                  Consumer<CartManager>(builder: (context, value, child) {
                    return TopRightBadge(
                      data: value.countItem(),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: Color.fromARGB(255, 255, 0, 204),
                        ),
                      ),
                    );
                  }),
                  PopupMenuButton(
                    color: const Color.fromARGB(221, 0, 0, 0),
                    iconColor: Colors.black,
                    onSelected: (value) => (),
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Chọn tất cả',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Bạn có chắn chắn xóa tất cả sản phẩm trong giỏ hàng?',
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
                                              Navigator.pop(ctx);
                                            },
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await _removeAllItem();
                                              Navigator.pop(context);
                                              //  Navigator.of(context).pop();
                                            },
                                            child: const Text('Xác nhận'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                            'Xóa tất cả',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Consumer<CartManager>(
                    builder: (context, cartManager, child) {
                  if (cartManager.cart.isNotEmpty) {
                    // List<bool> isCheckedList = List.generate(
                    //     cartManager.cart.length, (index) => false);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 229,
                            child: ListView.builder(
                              itemCount: cartManager.cart.length,
                              itemBuilder: (context, index) {
                                final CartModel cart = cartManager.cart[index];
                                total = total +
                                    (cart.cartBuyQuantity * cart.quantity);

                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(0.3),
                                          1: FlexColumnWidth(0.76),
                                          2: FlexColumnWidth(0.5),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Column(
                                                  children: [
                                                    Image(
                                                      image: MemoryImage(
                                                          cart.imageUrl[0]),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 10, 0, 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      'Bạn có chắn chắn xóa?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    content:
                                                                        const Icon(
                                                                      Icons
                                                                          .warning,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    actions: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                const Text('Hủy'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              _removeOneItem(cart.cartId);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                const Text('Xác nhận'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child:
                                                                const CircleAvatar(
                                                              radius: 15,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          139,
                                                                          138,
                                                                          138),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              TableCell(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cart.pdName,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Màu: ${cart.colorNameVn}',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                    ),
                                                    Text(
                                                      ' ${cart.optMemory}GB',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            _formatPrice(cart
                                                                .optPrice
                                                                .toString()),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          const Text(
                                                            '₫',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 130,
                                                        height: 40,
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .black, // Thay đổi màu chữ
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        3),
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        CartManager>()
                                                                    .updateQuantity(
                                                                        cart
                                                                            .cartId,
                                                                        context
                                                                            .read<LoginService>()
                                                                            .userId);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.add),
                                                            ),
                                                            prefixIcon:
                                                                IconButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        CartManager>()
                                                                    .removeQuantity(
                                                                        cart
                                                                            .cartId,
                                                                        context
                                                                            .read<LoginService>()
                                                                            .userId);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.remove),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    237,
                                                                    217,
                                                                    217),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          controller:
                                                              TextEditingController(
                                                                  text: cart
                                                                      .cartBuyQuantity
                                                                      .toString()),
                                                        ),
                                                      ),
                                                      Checkbox(
                                                        value: cart.checked,
                                                        onChanged:
                                                            (bool? value) {
                                                          cartManager.check(
                                                              index,
                                                              cart.cartId);
                                                          cartManager
                                                              .notifyListeners();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Tạm tính: ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              _formatPrice((cart.optPrice *
                                                      cart.cartBuyQuantity)
                                                  .toString()),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              '₫',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Divider(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(115, 0, 234, 255),
                                spreadRadius: 4,
                                blurRadius: 50,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        _formatPrice(
                                            cartManager.total.toString()),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.red),
                                      ),
                                      const Text(
                                        '₫',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                cartManager.total != 0
                                    ? TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PaymentAllScreen()));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      254, 255, 200, 0)),
                                          side: MaterialStateProperty.all<
                                              BorderSide>(
                                            const BorderSide(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              width: 1.2,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5), // Tắt radius
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Thanh Toán',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      254, 255, 200, 0)),
                                          side: MaterialStateProperty.all<
                                              BorderSide>(
                                            const BorderSide(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              width: 1.2,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5), // Tắt radius
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Vui lòng chọn sản phẩm',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const CartNoItemScreen();
                  }
                }),
              ),
            );
          },
        );
      },
    );
  }
}

class CartNoItemScreen extends StatefulWidget {
  const CartNoItemScreen({super.key});

  @override
  State<CartNoItemScreen> createState() => _CartNoItemScreenState();
}

class _CartNoItemScreenState extends State<CartNoItemScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Column(
      children: [
        const SizedBox(height: 240),
        const Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Giỏ hàng của bạn hiện tại đang trống',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(
          height: 260,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    bottomNavigationModel.setSelectedIndex(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mua Ngay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
