import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/admin/ui/account/manager/account_detail_screen.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:provider/provider.dart';

class SearchUserScreen extends StatefulWidget {
  final String name;
  const SearchUserScreen({required this.name, super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchUserSearch(widget.name);
  }

  int color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách tìm kiếm", style: GoogleFonts.aBeeZee()),
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
        actions: [],
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Consumer<UserManager>(
                builder: (context, userManager, child) {
                  if (userManager.userSearch.isNotEmpty) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userManager.userSearch.length,
                          itemBuilder: (context, index) {
                            UserModel user = userManager.userSearch[index];
                            color = index % 2;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AccountDetailScreen(account: user),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: color == 0
                                            ? const Color.fromARGB(
                                                255, 22, 124, 132)
                                            : const Color.fromARGB(
                                                255, 148, 128, 16),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 20,
                                      child: user.image == null
                                          ? const CircleAvatar(
                                              radius: 35,
                                              backgroundImage: AssetImage(
                                                  'assets/icon/icon_user.png'),
                                            )
                                          : CircleAvatar(
                                              radius: 35,
                                              backgroundImage: MemoryImage(
                                                user.image!,
                                              ),
                                            ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 8),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    user.name,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 8),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    user.email!,
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
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset('assets/icon/user_admin.png'),
                          const Text(
                            "Không có tài khoản nào",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
