import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/order.dart';

import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/order/order_detail_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_detail_screen.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:provider/provider.dart';

class WaittingOrderScreen extends StatefulWidget {
  const WaittingOrderScreen({super.key});

  @override
  State<WaittingOrderScreen> createState() => _WaittingOrderScreenState();
}

class _WaittingOrderScreenState extends State<WaittingOrderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrder();
    _fetchOrderDetail();
  }

  Future<void> _fetchOrder() async {
    await context
        .read<OrderManager>()
        .fetchOrder(context.read<LoginService>().userId);
  }

  Future<void> _fetchOrderDetail() async {
    await context
        .read<OrderDetailManager>()
        .fetchOrderDetail(context.read<LoginService>().userId);
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer2<OrderManager, OrderDetailManager>(
        builder: (context, orderManager, orderDetailManager, child) {
          List<OrderModel> orderList = [];
          for (var order in orderManager.orderList) {
            if (order.status == "Chờ xác nhận") {
              orderList.add(order);
            }
          }
          if (orderList.isNotEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 213,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  int quantity = 0;
                  final order = orderManager.orderList[index];

                  final orderDetails = orderDetailManager.orderDetailList
                      .where((detail) => detail.orderId == order.orderId)
                      .toList();
                  return GestureDetector(
                    onTap: () {
                      print(order.orderId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailScreen(orderId: order.orderId!),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Row(
                            children: [
                              const Text(
                                "Ngày đặt: ",
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy, HH:mm:ss')
                                    .format(order.date!),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        // Text('Order ID: ${order.code}'),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderDetails.length,
                          itemBuilder: (context, index) {
                            final detail = orderDetails[index];
                            for (var order in orderDetails) {
                              quantity = quantity + order.odQuantity;
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(0.3),
                                      1: FlexColumnWidth(0.7),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Image(
                                                      image: MemoryImage(
                                                          detail.odImage),
                                                      width: 115,
                                                      height: 115,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      detail.odPdName,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${detail.odPdMemory}GB',
                                                      style: const TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      detail.odPdColor,
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              135,
                                                              134,
                                                              134)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 22),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _formatPrice(detail
                                                                .odPdPrice
                                                                .toString()) +
                                                            "đ",
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        'x${detail.odQuantity}',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Divider(
                                    color: Color.fromARGB(255, 222, 194, 194),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // Hàm tính tổng các quantity của tất cả đơn hàng
                              child: Text(
                                'Tổng số lượng mặt hàng: ${orderDetails.fold<int>(0, (total, order) => total + order.odQuantity)} ',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 0),
                              // Hàm tính tổng các quantity của tất cả đơn hàng
                              // child: Text(
                              //   'Tổng thanh toán: ${orderDetails.fold<double>(0, (total, order) => total + (order.odQuantity * order.odPdPrice))}',
                              //   style: const TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold),
                              // ),
                              child: Text(
                                'Tổng thanh toán: ${_formatPrice(order.total.toString())}đ',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        const Divider(
                          height: 20,
                          thickness: 10,
                          color: Color.fromARGB(255, 218, 215, 215),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/image/icon_order.jpg'),
                      width: 100,
                    ),
                    Text(
                      "Chưa có đơn hàng nào",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
