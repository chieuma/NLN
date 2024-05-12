import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/models/order_detail.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/order/order_detail_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_screen.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  late int orderId;
  OrderDetailScreen({required this.orderId, super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<OrderManager>()
        .fetchOrder(context.read<LoginService>().userId);
    context
        .read<OrderDetailManager>()
        .fetchOrderDetail(context.read<LoginService>().userId);
  }

  Future<void> _removeOrder(
      OrderModel order, List<OrderDetailModel> orderDetail) async {
    context.read<ProductDetailManager>().removeOrder(order, orderDetail);
  }

  Future<void> _updateOrder(OrderModel order) async {
    context.read<OrderManager>().updateOrder(order);
  }

  Future<void> _updateOrderDetail(List<OrderDetailModel> orderDetail) async {
    context.read<OrderDetailManager>().updateOrderDetail(orderDetail);
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông Tin Đơn Hàng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
              size: 30,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer2<OrderManager, OrderDetailManager>(
              builder: (context, orderManager, orderDetailManager, child) {
                final List<OrderModel> order = orderManager.orderList
                    .where((element) => element.orderId! == widget.orderId)
                    .toList();

                if (order.isNotEmpty) {
                  return SizedBox(
                    height: 700,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: order.length,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final orderDetails = orderDetailManager.orderDetailList
                            .where(
                                (detail) => detail.orderId == order[0].orderId)
                            .toList();
                        // print(orderDetails.length);
                        return Column(
                          children: [
                            order[0].status! == 'Chờ xác nhận'
                                ? Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Bạn có chắc chắn hủy đơn hàng này?',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  content: const Icon(
                                                    Icons.warning,
                                                    color: Colors.red,
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('Hủy'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await _removeOrder(
                                                                order[0],
                                                                orderDetails);
                                                            Navigator.pop(
                                                                context);

                                                            await _updateOrder(
                                                                order[0]);
                                                            await _updateOrderDetail(
                                                                orderDetails);
                                                          },
                                                          child: const Text(
                                                              'Xác nhận'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 0, 0, 0),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Hủy đơn hàng',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ],
                                  )
                                : Container(),
                            Container(
                              color: const Color.fromARGB(255, 5, 191, 163),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          order[0].status!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          'Ngày nhận hàng dự kiến',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          'Lưu ý: đây là đơn hàng Thanh toán khhi nhận hàng',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 10,
                              color: Color.fromARGB(255, 226, 224, 221),
                            ),
                            Container(
                              color: const Color.fromARGB(255, 254, 255, 255),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.security_outlined,
                                          color:
                                              Color.fromARGB(255, 168, 51, 42),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '  Những điều cần lưu ý khi nhận hàng',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 37),
                                            child: Text(
                                              'Nếu có vấn đề gì đối với đơn hàng, vui lòng liên hệ đến shop để yêu cầu đổi trả hàng trong vòng 3 ngày kể từ ngày nhận hàng.',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 104, 101, 101),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 35),
                                          child: Text(
                                            'Tìm hiểu',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 51, 168),
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 10,
                              color: Color.fromARGB(255, 226, 224, 221),
                            ),
                            Container(
                              color: const Color.fromARGB(255, 254, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color:
                                              Color.fromARGB(255, 80, 79, 79),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '  Địa chỉ nhận hàng',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 37),
                                            child: Text(
                                              order[0].name,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 47, 47, 47),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 37),
                                            child: Text(
                                              order[0].tel,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 47, 47, 47),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 37),
                                            child: Text(
                                              order[0].address,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 47, 47, 47),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 10,
                              color: Color.fromARGB(255, 226, 224, 221),
                            ),
                            SizedBox(
                              height: (140 * orderDetails.length).toDouble(),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: orderDetails.length,
                                itemBuilder: (context, index) {
                                  return Column(
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
                                                                orderDetails[
                                                                        index]
                                                                    .odImage),
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
                                                            orderDetails[index]
                                                                .odPdName,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${orderDetails[index].odPdMemory}GB',
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            orderDetails[index]
                                                                .odPdColor,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        135,
                                                                        134,
                                                                        134)),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 22),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${_formatPrice(orderDetails[index].odPdPrice.toString())}đ',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            Text(
                                                              'x${orderDetails[index].odQuantity}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Divider(
                                          color: Color.fromARGB(
                                              255, 222, 194, 194),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: const Color.fromARGB(255, 254, 255, 255),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          color:
                                              Color.fromARGB(255, 80, 79, 79),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '  Phương thưc thanh toán',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 37),
                                            child: Text(
                                              "Thanh toán khi nhận hàng",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 47, 47, 47),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 10,
                              color: Color.fromARGB(255, 226, 224, 221),
                            ),
                            Container(
                              color: const Color.fromARGB(255, 254, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.code,
                                              color: Color.fromARGB(
                                                  255, 80, 79, 79),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                '  Mã đơn hàng',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                '  ADNSMHWGDGW',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Text(
                                                '  Thời gian đặt hàng',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 122, 122, 122),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                DateFormat(
                                                        'dd-MM-yyyy, HH:mm:ss')
                                                    .format(order[0].date!),
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 85, 84, 84),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Text(
                                                '  Thời gian giao hàng dự kiến',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 122, 122, 122),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                DateFormat(
                                                        'dd-MM-yyyy, HH:mm:ss')
                                                    .format(order[0].date!),
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 85, 84, 84),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                                height: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 118, 216, 200)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.message,
                                        color:
                                            Color.fromARGB(255, 255, 5, 146)),
                                    Text(
                                      "  Liên hệ SHOP",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 26, 11, 11),
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (order.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 0, 154, 20),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Bạn đã hủy thành công",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
