import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/models/order_detail.dart';
import 'package:mobile_app_3/client/ui/order/order_detail_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderModel order;
  OrderDetailScreen({required this.order, super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<OrderDetailManager>()
        .fetchAllDetailOrder(widget.order.orderId!);
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn hàng",
          style: GoogleFonts.aBeeZee(),
        ),
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
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [
          widget.order.status == "Chờ xác nhận"
              ? IconButton(
                  onPressed: () {
                    showCheckOrderDialog(
                        context,
                        "Bạn có chắc chắn xác nhận đơn hàng này?",
                        widget.order.orderId!);
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                )
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text(widget.order.orderId.toString()),
            Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 0, 78, 3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Ngày và giờ đặt",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy, HH:mm:ss')
                                  .format(widget.order.date!),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng thanh toán",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 142, 250, 246),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              "${_formatPrice(widget.order.total.toString())}đ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 142, 250, 246),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Thông tin người nhận",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 123, 0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tên khách hàng",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.order.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 109, 109, 109)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.order.email,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 109, 109, 109)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Số điện thoại",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.order.tel,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 109, 109, 109)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Địa chỉ nhận hàng",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.order.address,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 109, 109, 109)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Divider(
                    color: Color.fromARGB(255, 222, 142, 142),
                  ),
                )
              ],
            ),
            Consumer<OrderDetailManager>(
              builder: (context, orderDetail, child) {
                if (orderDetail.orderList.isNotEmpty) {
                  return Column(
                    children: [
                      const Text(
                        "Thông tin chi tiết sản phẩm",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 123, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderDetail.orderList.length,
                        itemBuilder: (context, index) {
                          OrderDetailModel order = orderDetail.orderList[index];
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
                                                        order.odImage),
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
                                                    order.odPdName,
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
                                                    '${order.odPdMemory}GB',
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
                                                    order.odPdColor,
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
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${_formatPrice(order.odPdPrice.toString())}đ",
                                                      style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      'x${order.odQuantity}',
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
                      )
                    ],
                  );
                } else
                  return Text("Có lỗi trong quá trình hiển thị dữ liệu");
              },
            ),
          ],
        ),
      ),
    );
  }
}
