import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:mobile_app_3/client/ui/product/phone_screen.dart';
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
    //  final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Text(
                          '$dayName, ${now.day} $monthName',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 96, 92, 92)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 600,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2, // Số lượng mục trong danh sách
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // Mục đầu tiên với PageView
                            return Container(
                              width: width,
                              height: 300,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: _pageController,
                                    itemCount: firstContainerImagePaths.length,
                                    onPageChanged: (pageIndex) {
                                      setState(() {
                                        currentPage = pageIndex;
                                      });
                                    },
                                    itemBuilder: (context, pageIndex) {
                                      return Image.asset(
                                        firstContainerImagePaths[pageIndex],
                                        width: width,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 40,
                                    left: 70,
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PhoneScreen(
                                                categoryId: 1,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Row(
                                          children: [
                                            Text(
                                              'BUY NOW',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (index == 1) {
                            // Mục thứ hai với ảnh laptop
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Container(
                                width: width,
                                height: 300,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/logo_laptop.jpg'),
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
                                            bottom: 40,
                                            left: 70,
                                            child: SizedBox(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                ),
                                                onPressed: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         const LaptopScreen(
                                                  //       name: 'Laptop',
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Text(
                                                      'BUY NOW',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 12,
                                            right: 10,
                                            child: SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Hiệu Năng',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    ' Mạnh mẽ',
                                                    style: TextStyle(
                                                        fontSize: 26,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Đồ họa',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    ' Tuyệt đẹp',
                                                    style: TextStyle(
                                                        fontSize: 26,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.red),
                                                  ),
                                                ],
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
                          return null;
                        },
                      ),
                    ),
                    const Category(),
                    const FavoriteAndAccount(),
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

class FavoriteAndAccount extends StatefulWidget {
  const FavoriteAndAccount({super.key});

  @override
  State<FavoriteAndAccount> createState() => _FavoriteAndAccountState();
}

class _FavoriteAndAccountState extends State<FavoriteAndAccount> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
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
                image: AssetImage('assets/image/favorite.jpg'),
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
                        bottom: 10,
                        left: 33,
                        child: SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                            onPressed: () {
                              bottomNavigationModel.setSelectedIndex(2);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'YÊU THÍCH',
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
                image: AssetImage('assets/image/user.jpg'),
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
                        bottom: 10,
                        left: 33,
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
                              bottomNavigationModel.setSelectedIndex(4);
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

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/Apple/iphone_15_3.jpg'),
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
                      top: 10,
                      left: 10,
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.blue,
                            elevation: 10,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Điện Thoại',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 80,
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'LapTop',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 150,
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.blue,
                            elevation: 10,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Tai Nghe',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 220,
                      child: SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Phụ Kiện',
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
      ],
    );
  }
}
