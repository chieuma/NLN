import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/admin/ui/account/manager/account_admin_screen.dart';
import 'package:mobile_app_3/admin/ui/account/manager/account_client_screen.dart';
import 'package:mobile_app_3/admin/ui/account/manager/account_staff_screen.dart';
import 'package:mobile_app_3/admin/ui/shared/build_search_screen.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:provider/provider.dart';

class AccountManagerScreen extends StatefulWidget {
  const AccountManagerScreen({super.key});

  @override
  State<AccountManagerScreen> createState() => _AccountManagerScreenState();
}

class _AccountManagerScreenState extends State<AccountManagerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quản lý tài khoản",
          style: GoogleFonts.aBeeZee(),
        ),
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BuildSearchUserField()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 320,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 23, 203, 235)
                          .withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountAdminScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 400,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 252, 64, 240),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 20,
                              child: Image.asset(
                                'assets/icon/user_admin.png',
                                width: 80,
                              ),
                            ),
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tài Khoản Admin",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Số lượng - ${context.read<UserManager>().countAdminAccount()}",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 223, 218, 218),
                                                fontSize: 18),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountStaffScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 400,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 38, 164, 254),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 5,
                                right: 20,
                                child: Image.asset(
                                  'assets/icon/user_staff.png',
                                  width: 80,
                                )),
                            const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tài Khoản Nhân Viên",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Số lượng - 1",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 223, 218, 218),
                                                fontSize: 18),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountClientScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 400,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 154, 50, 245),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 13,
                                right: 20,
                                child: Image.asset(
                                  'assets/icon/icon_user.png',
                                  width: 60,
                                )),
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tài Khoản Khách Hàng",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 8),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Consumer<UserManager>(
                                            builder: (context, value, child) {
                                              if (value.userAll.isNotEmpty) {
                                                return Text(
                                                  "Số lượng - ${value.countClientAccount}",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 223, 218, 218),
                                                      fontSize: 18),
                                                );
                                              }
                                              return const Text(
                                                "Số lượng - 0",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 223, 218, 218),
                                                    fontSize: 18),
                                              );
                                            },
                                          )

                                          // Text(
                                          //   "Số lượng - ${context.read<UserManager>.countClientAccount}",
                                          //   style: const TextStyle(
                                          //       color: Color.fromARGB(
                                          //           255, 223, 218, 218),
                                          //       fontSize: 18),
                                          // )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
