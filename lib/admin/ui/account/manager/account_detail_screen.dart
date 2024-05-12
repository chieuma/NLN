import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/admin/ui/account/manager/edit_account_screen.dart';
import 'package:mobile_app_3/admin/ui/statistical/statistical_manager.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/favorite/favorite_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDetailScreen extends StatefulWidget {
  final UserModel account;
  const AccountDetailScreen({required this.account, super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  String user_role = '';
  @override
  void initState() {
    super.initState();
    context.read<StatisticalManager>().fetchStatistical();
    user_role = context.read<LoginService>().userRole;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết tài khoản",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 227, 227),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 53, 215, 248)
                          .withOpacity(0.6),
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: const Offset(4, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tên đăng nhập",
                              style: GoogleFonts.aBeeZee(fontSize: 16)
                              //  style: TextStyle(fontSize: 16),
                              ),
                          Text(
                            widget.account.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tên đầy đủ',
                            style: GoogleFonts.aBeeZee(fontSize: 16),
                          ),
                          widget.account.fullName == null
                              ? const Text(
                                  'Chưa có',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              : Text(
                                  widget.account.fullName!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mật khẩu",
                              style: GoogleFonts.aBeeZee(fontSize: 16)),
                          Text(
                            widget.account.password,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email',
                              style: GoogleFonts.aBeeZee(fontSize: 16)),
                          widget.account.email == null
                              ? const Text(
                                  'Chưa có',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              : Text(
                                  widget.account.email!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Địa chỉ',
                              style: GoogleFonts.aBeeZee(fontSize: 16)),
                          widget.account.address == null
                              ? const Text(
                                  'Chưa có',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              : Text(
                                  widget.account.address!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Số điện thoại',
                              style: GoogleFonts.aBeeZee(fontSize: 16)),
                          widget.account.tel == null
                              ? const Text(
                                  'Chưa có',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              : Text(
                                  widget.account.tel!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ngày đăng ký",
                              style: GoogleFonts.aBeeZee(fontSize: 16)),
                          Text(
                            DateFormat('dd-MM-yyyy, HH:mm:ss')
                                .format(widget.account.date),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ảnh đại diện',
                              style: GoogleFonts.aBeeZee(fontSize: 16)),
                          widget.account.image == null
                              ? const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                    'assets/icon/user.png',
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: MemoryImage(
                                    widget.account.image!,
                                  ),
                                ),
                        ],
                      ),
                      user_role == "admin"
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditAccountScreen(user: widget.account),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              child: const Text(
                                "Cập nhật",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.account.role == "client"
                ? Column(
                    children: [
                      Container(
                        width: 160,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 135, 221, 152),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Thông tin thêm",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 229, 161, 24),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Số lượng đơn hàng đã xác nhận",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      context
                                          .read<OrderManager>()
                                          .countChecked(widget.account.id!)
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 40, 35, 26),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Số lượng đơn hàng chờ xác nhận",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    Text(
                                      context
                                          .read<OrderManager>()
                                          .countNoChecked(widget.account.id!)
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 229, 161, 24),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Số lượng sản phẩm yêu thích",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      context
                                          .read<FavoriteManager>()
                                          .countFavoriteItem(widget.account.id!)
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 40, 35, 26),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Số lượng truy cập",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    Text(
                                      context
                                          .read<StatisticalManager>()
                                          .countStatistical(widget.account.id!)
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
