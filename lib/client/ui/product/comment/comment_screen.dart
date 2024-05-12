import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:mobile_app_3/client/ui/product/comment/comment_manager.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final int pdId;

  const CommentScreen({required this.pdId, super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommentManager>().fetchComment(widget.pdId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Bình luận",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        Consumer<CommentManager>(builder: (context, value, child) {
          if (value.listComment.isNotEmpty) {
            return SizedBox(
              height: value.listComment.length > 1 ? 200 : 100,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value.listComment[index].userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(value.listComment[index].dateTime))
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20, right: 8, top: 0),
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
          return const Center(
            child: Text(
              "Không có bình luận nào!",
              style: TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          );
        })
      ],
    );
  }
}
