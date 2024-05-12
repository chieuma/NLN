import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_3/admin/ui/product/addProduct.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/account/help_screen.dart';
import 'package:mobile_app_3/client/ui/account/transport_screen.dart';
import 'package:mobile_app_3/client/ui/account/user/edit_image_screen.dart';
import 'package:mobile_app_3/client/ui/account/user/edit_pasword.dart';
import 'package:mobile_app_3/client/ui/account/user/edit_profile_screen.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/account/warranty_screen.dart';
import 'package:mobile_app_3/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:mobile_app_3/client/ui/order/order_screen.dart';
import 'package:mobile_app_3/main.dart';

import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'TÀI KHOẢN CÁ NHÂN',
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
                  shadowColor: Colors.black,
                  elevation: 4,
                ),
                body: const SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(child: HeaderAccount()),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class HeaderAccount extends StatefulWidget {
  const HeaderAccount({super.key});

  @override
  State<HeaderAccount> createState() => _HeaderAccountState();
}

class _HeaderAccountState extends State<HeaderAccount>
    with SingleTickerProviderStateMixin {
  late Future<List<UserModel>> _fetchUser;

  @override
  void initState() {
    super.initState();
    _fetchUser = context
        .read<UserManager>()
        .fetchUser(context.read<LoginService>().userId);
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Consumer<UserManager>(
      builder: (context, userManager, child) {
        if (userManager.user.isNotEmpty) {
          final UserModel user = userManager.user.first;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: user.image != null &&
                        user.image!
                            .isNotEmpty // Kiểm tra nếu trường image không null và không rỗng
                    ? CircleAvatar(
                        radius: 40,
                        backgroundImage: MemoryImage(
                          user.image!,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/icon/user.png'),
                      ),
              ),
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(user.email ?? 'Chưa có email'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfileScreen(fetchUser: user)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      side: const BorderSide(width: 0.8, color: Colors.black),
                    ),
                    child: const Text(
                      'CHỈNH SỬA THÔNG TIN',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CircleAvatar(
                          radius: 30,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyImagePicker()));
                            },
                            child: const Icon(
                              Icons.photo_camera,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Đổi ảnh\n đại diện',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.source,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text('Sản phẩm \nđã xem',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 30,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         const SearchItem(),
                              //   ),
                              // );
                            },
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Text('Mục đã  \ntìm kiếm',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 30,
                          child: GestureDetector(
                            onTap: () {
                              bottomNavigationModel.setSelectedIndex(2);
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const Text('Sản phẩm \nyêu thích',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Divider(
                  color: Color.fromARGB(255, 238, 185, 185),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 230, 221, 221),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditPasswordScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.key_outlined,
                                color: Colors.green,
                              ),
                              Text(' Thay đổi mật khẩu'),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: //ORDER
                    const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 230, 221, 221),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderScreen(),
                          ),
                        );
                      },
                      child: //ORDER
                          const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.red,
                              ),
                              Text(' Lịch sử đặt hàng'),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Divider(
                  color: Color.fromARGB(255, 234, 198, 198),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 230, 221, 221),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HelpScreen()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.help_outline,
                                    color: Color.fromARGB(255, 255, 0, 183),
                                  ),
                                  Text(' Trung tâm trợ giúp'),
                                ],
                              ),
                              Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 230, 221, 221),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TranSportScreen()));
                            },
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_shipping_outlined,
                                          color: Color.fromARGB(255, 250, 0, 0),
                                        ),
                                        Text(' Chính sách vận chuyển'),
                                      ],
                                    ),
                                    Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 230, 221, 221),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WarrantyScreen()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.privacy_tip_outlined,
                                      color: Color.fromARGB(255, 14, 170, 0),
                                    ),
                                    Text(' Chính sách bảo hành'),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 230, 221, 221),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Color.fromARGB(255, 206, 155, 0),
                                    ),
                                    Text(' Chính sách khiếu nại'),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Divider(
                  color: Color.fromARGB(255, 234, 198, 198),
                ),
              ),
              const Logout(),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phiên bản 1.1.12.v298",
                      style: TextStyle(
                          color: Color.fromARGB(255, 109, 126, 0),
                          fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 232, 51, 6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<LoginService>().logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AppWrapper()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    Text(
                      ' Đăng xuất',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
