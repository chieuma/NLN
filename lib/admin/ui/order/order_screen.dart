import 'package:flutter/material.dart';
import 'package:mobile_app_3/admin/ui/order/waitting_order_screen.dart';
import 'package:mobile_app_3/admin/ui/order/ordered_screen.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Widget> _listStatus = [
    WaittingOrderScreen(),
    OrderedScreen(),
  ];
  final List<String> _listName = [
    'Chờ xác nhận',
    'Đã xác nhận',
  ];
  int _selectedMenuIndex = 0;
  bool selected = true;

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
                  "Quản Lý Đơn Hàng",
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
                shadowColor: Colors.orange,
                elevation: 4,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _selectedMenuIndex == 0
                        ? Consumer<OrderManager>(
                            builder: (context, orderManager, child) {
                            List<OrderModel> list = [];
                            for (var order in orderManager.orderListAdmin) {
                              if (order.status == "Chờ xác nhận") {
                                list.add(order);
                              }
                            }
                            if (list.isNotEmpty) {
                              return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 195, 112, 112),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      list.length.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ));
                            } else {
                              return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 195, 112, 112),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      list.length.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ));
                            }
                          })
                        : Consumer<OrderManager>(
                            builder: (context, orderManager, child) {
                              List<OrderModel> list = [];
                              for (var order in orderManager.orderListAdmin) {
                                if (order.status == "Đã xác nhận") {
                                  list.add(order);
                                }
                              }
                              if (list.isNotEmpty) {
                                return Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 255, 217, 0),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        list.length.toString(),
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ));
                              } else {
                                return Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 246, 255, 0),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      list.length.toString(),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
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
                    Column(
                      children: [
                        _listStatus[_selectedMenuIndex],
                      ],
                    )
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
