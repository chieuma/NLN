import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_3/admin/ui/search_user/search_user_screen.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/search/search_manager.dart';

import 'package:provider/provider.dart';

class BuildSearchUserField extends StatefulWidget {
  const BuildSearchUserField({super.key});

  @override
  State<BuildSearchUserField> createState() => _BuildSearchUserFieldState();
}

class _BuildSearchUserFieldState extends State<BuildSearchUserField> {
  final TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: // Thêm padding bên trái
            TextField(
          controller: name,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {
                if (name.text.trim() == '') {
                  Fluttertoast.showToast(
                      msg: "Giá trị tìm kiếm không được rỗng",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: const Color.fromARGB(255, 214, 107, 25));
                } else {
                  context.read<SearchManager>().addSearch(
                      context.read<LoginService>().userId, name.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchUserScreen(name: name.text),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.search),
            ),
            hintText: 'Tìm kiếm nguời dùng',
            border: InputBorder.none,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          // onChanged: () {
          //   // Perform search-related operations here
          // },
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 3, right: 8),
              child: Text(
                "Hủy",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      // body: Consumer<SearchManager>(builder: (context, searchManager, child) {
      //   if (searchManager.itemSearch.isNotEmpty) {
      //     return ListView.builder(
      //       itemCount: searchManager.itemCount,
      //       itemBuilder: (context, index) {
      //         return Padding(
      //           padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
      //           child: Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Row(
      //                     children: [
      //                       IconButton(
      //                         onPressed: () {
      //                           // print(_listPopularSearch[index]);
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                               builder: (context) => SearchUserScreen(
      //                                   name: searchManager
      //                                       .itemSearch[index].name),
      //                             ),
      //                           );
      //                         },
      //                         icon: const Icon(
      //                           Icons.search,
      //                           color: Color.fromARGB(255, 157, 151, 151),
      //                         ),
      //                       ),
      //                       GestureDetector(
      //                         onTap: () {
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => SearchScreen(
      //                                       name: searchManager
      //                                           .itemSearch[index].name)));
      //                         },
      //                         child: Text(searchManager.itemSearch[index].name,
      //                             style: const TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 16)),
      //                       ),
      //                     ],
      //                   ),
      //                   Row(
      //                     children: [
      //                       IconButton(
      //                           onPressed: () {
      //                             searchManager.clearSearch(
      //                                 context.read<LoginService>().userId,
      //                                 searchManager.itemSearch[index].name);
      //                           },
      //                           icon: const Icon(
      //                             Icons.close,
      //                             color: Colors.red,
      //                           ))
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   }
      //   return Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }),
    );
  }
}
