import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:mobile_app_3/client/ui/order/ordered_screen.dart';
import 'package:mobile_app_3/client/ui/order/waittting_order_screen.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context
        .read<OrderManager>()
        .fetchOrder(context.read<LoginService>().userId);
  }

  final List<Widget> _listStatus = [
    WaittingOrderScreen(),
    OrderedScreen(),
  ];
  final List<String> _listName = [
    'Chờ xác nhận',
    'Đã xác nhận',
  ];
  int _selectedMenuIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quản Lý Đơn Hàng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.orange,
        elevation: 4,
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 37,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listName.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedMenuIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedMenuIndex == index
                                  ? Colors.red
                                  : const Color.fromARGB(0, 22, 67, 74),
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          _listName[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _selectedMenuIndex == index
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Expanded(
          //   child: Center(
          //     child: Container(
          //       color: const Color.fromARGB(255, 219, 219, 219),
          //       child: ListView(
          //         children: const [
          //           Column(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.only(top: 50),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.all(Radius.circular(50)),
          //                   child: Image(
          //                     image: AssetImage('assets/image/icon_order.jpg'),
          //                     fit: BoxFit.cover,
          //                     width: 100,
          //                   ),
          //                 ),
          //               ),
          //               Text('Chưa có đơn hàng'),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            children: [
              _listStatus[_selectedMenuIndex],
            ],
          )
        ],
      ),
    );
  }
}
