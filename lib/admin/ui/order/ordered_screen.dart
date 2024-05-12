import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/admin/ui/order/order_detail_screen.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:provider/provider.dart';

class OrderedScreen extends StatefulWidget {
  const OrderedScreen({super.key});

  @override
  State<OrderedScreen> createState() => _OrderedScreenState();
}

class _OrderedScreenState extends State<OrderedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderManager>().fetchAllOrder();
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<OrderManager>(
        builder: (context, orderManager, child) {
          if (orderManager.orderListAdmin.isNotEmpty) {
            List<OrderModel> orderList = [];
            for (var order in orderManager.orderListAdmin) {
              if (order.status == "Đã xác nhận") {
                orderList.add(order);
              }
            }
            if (orderList.isNotEmpty) {
              return SizedBox(
                height: 660,
                child: ListView.builder(
                  //  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailScreen(order: orderList[index]),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Ngày và giờ đặt",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy, HH:mm:ss')
                                      .format(orderList[index].date!),
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Tên khách hàng",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  orderList[index].name,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Số điện thoại",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  orderList[index].tel,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 4, 134, 4)),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Tổng thanh toán",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${_formatPrice(orderList[index].total.toString())}đ',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 242, 6, 6)),
                                ),
                              ],
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Color.fromARGB(255, 182, 174, 174),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icon/order_yes.png',
                      width: 120,
                      height: 120,
                    ),
                    const Text(
                      "Chưa có đơn hàng đã xác nhận nào",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/icon_order.jpg',
                    width: 120,
                    height: 120,
                  ),
                  const Text(
                    "Chưa có đơn hàng nào",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
