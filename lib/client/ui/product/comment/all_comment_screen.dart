import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mobile_app_3/client/ui/product/comment/comment_manager.dart';
import 'package:provider/provider.dart';

class AllCommentScreen extends StatelessWidget {
  const AllCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tất Cả Bình Luận"),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<CommentManager>(builder: (context, value, child) {
              if (value.listComment.isNotEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: value.listComment.length > 20
                          ? 20
                          : value.listComment.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.listComment[index].userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                      value.listComment[index].dateTime))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 8, top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(value.listComment[index].comment),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Không có bình luận nào",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
