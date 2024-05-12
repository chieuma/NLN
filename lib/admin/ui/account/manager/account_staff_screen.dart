import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/admin/ui/account/manager/account_detail_screen.dart';
import 'package:mobile_app_3/admin/ui/account/manager/add_account_screen.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:provider/provider.dart';

class AccountStaffScreen extends StatefulWidget {
  const AccountStaffScreen({super.key});

  @override
  State<AccountStaffScreen> createState() => _AccountStaffScreenState();
}

class _AccountStaffScreenState extends State<AccountStaffScreen> {
  String user_role = '';
  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchAllUser();
    user_role = context.read<LoginService>().userRole;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tài khoản nhân viên",
          style: GoogleFonts.aBeeZee(),
        ),
        centerTitle: true,
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
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            await context.read<UserManager>().fetchAllUser();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, right: 0),
        child: Column(
          children: [
            user_role == "admin"
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddAccountScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                            ),
                          ),
                          child: const Text(
                            "Thêm tài khoản",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Consumer<UserManager>(
              builder: (context, userManager, child) {
                if (userManager.userAll.isNotEmpty) {
                  List<UserModel> user = userManager.userAll
                      .where((element) => element.role == "staff")
                      .toList();
                  if (user.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 631.4,
                            child: ListView.builder(
                              shrinkWrap: true,
                              //  physics: const NeverScrollableScrollPhysics(),
                              itemCount: user.length,
                              itemBuilder: (context, index) {
                                int color = index % 2;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AccountDetailScreen(
                                                account: user[index]),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 90,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: color == 0
                                                ? const Color.fromARGB(
                                                    255, 220, 48, 208)
                                                : const Color.fromARGB(
                                                    255, 14, 151, 103),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 20,
                                          child: user[index].image == null
                                              ? const CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: AssetImage(
                                                      'assets/icon/user_admin.png'),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: MemoryImage(
                                                    user[index].image!,
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
                                                        user[index].name,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        user[index].email!,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    223,
                                                                    218,
                                                                    218),
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
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Text('Không có tài khoản nào');
                  }
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
