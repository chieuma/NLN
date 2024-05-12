import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_3/admin/ui/bottomnavigation/bottomnavigation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime.now();

  //Danh sách tháng bằng tiếng anh
  final List<String> englishMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

// GlobalKey
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final List<String> firstContainerImagePaths = [
    'assets/image/logo_iphone.jpg',
    'assets/image/logo_samsung.jpg',
    'assets/image/logo_headphone.jpg',
  ];

  //Tự động chuyển ảnh
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool forward = true;

  //Chuyển thứ sang tiếng anh
  String _getDayOfWeek(int dayIndex) {
    switch (dayIndex) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    // Gọi hàm tự động chuyển trang sau mỗi giây
    startTimer();
  }

  // Hàm để tự động chuyển trang sau mỗi giây
  void startTimer() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (forward) {
        // Chuyển tới trang tiếp theo
        if (currentPage < firstContainerImagePaths.length - 1) {
          currentPage++;
        } else {
          // Nếu đã đến hình ảnh cuối cùng, chuyển hướng ngược lại
          currentPage--;
          forward = false;
        }
      } else {
        // Chuyển về trang trước đó
        if (currentPage > 0) {
          currentPage--;
        } else {
          // Nếu đã đến trang đầu tiên, chuyển hướng tiếp
          currentPage++;
          forward = true;
        }
      }
      // Chuyển trang của PageView
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Lấy thứ tiếng anh
    String dayName = _getDayOfWeek(now.weekday);

    //Lấy tháng tiếng anh
    String monthName = englishMonths[now.month - 1];

    final double width = MediaQuery.of(context).size.width;
    final bottomNavigationModelAdmin =
        Provider.of<BottomNavigationModelAdmin>(context);

    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "DISCOVERY",
                  style: TextStyle(fontFamily: 'BebasNeue', fontSize: 27),
                ),
                shadowColor: Colors.black,
                elevation: 4,
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Text(
                          '$dayName, ${now.day} $monthName',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 96, 92, 92),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              body: const SingleChildScrollView(
                child: Column(
                  children: [
                    Header(),
                    Product(),
                    OrderAndAccount(),
                    Statistics(),
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

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModelAdmin =
        Provider.of<BottomNavigationModelAdmin>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.accessibility,
                            color: Color.fromARGB(255, 180, 54, 54),
                          ),
                          Text(
                            "  Số lượng truy cập",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 180, 54, 54),
                          ),
                          Text(
                            "  Tài khoản đã đăng ký",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.assignment,
                            color: Color.fromARGB(255, 62, 180, 54),
                          ),
                          Text(
                            "  Đơn hàng đã xác nhận",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.assignment,
                            color: Color.fromARGB(255, 180, 54, 54),
                          ),
                          Text(
                            "  Đơn hàng chưa xác nhận",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.store,
                            color: Color.fromARGB(255, 180, 54, 54),
                          ),
                          Text(
                            "  Số lượng sản phẩm",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Color.fromARGB(255, 180, 54, 54),
                          ),
                          Text(
                            "  Doanh thu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.face_2_sharp,
                              color: Color.fromARGB(255, 54, 180, 151),
                            ),
                            Text(
                              "  Vui lòng khách đến, vừa lòng khách đi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )
                          ],
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
    );
  }
}

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModelAdmin =
        Provider.of<BottomNavigationModelAdmin>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/logo_ipad.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          bottomNavigationModelAdmin.setSelectedIndex(1);
                        },
                        child: const Row(
                          children: [
                            Text(
                              'DANH SÁCH SẢN PHẨM',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderAndAccount extends StatefulWidget {
  const OrderAndAccount({super.key});

  @override
  State<OrderAndAccount> createState() => _OrderAndAccountState();
}

class _OrderAndAccountState extends State<OrderAndAccount> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModelAdmin =
        Provider.of<BottomNavigationModelAdmin>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width / 2) - 20,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/iphone_15.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                            onPressed: () {
                              bottomNavigationModelAdmin.setSelectedIndex(3);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'ĐƠN HÀNG',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width / 2) - 20,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/headphone.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              bottomNavigationModelAdmin.setSelectedIndex(4);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'TÀI KHOẢN',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModelAdmin =
        Provider.of<BottomNavigationModelAdmin>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/statistics.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        onPressed: () {
                          bottomNavigationModelAdmin.setSelectedIndex(2);
                        },
                        child: const Row(
                          children: [
                            Text(
                              'THỐNG KÊ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
