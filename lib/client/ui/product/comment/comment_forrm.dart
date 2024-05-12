import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/product/comment/comment_manager.dart';

import 'package:provider/provider.dart';

class CommentForm extends StatefulWidget {
  final int productId;
  const CommentForm({required this.productId, super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final TextEditingController _comment = TextEditingController();
  @override
  void initState() {
    super.initState();
    _comment.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bình luận sản phẩm",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  maxLines: 4,
                  maxLength: 60,
                  controller: _comment,
                  decoration: const InputDecoration(
                      labelText: 'Nội dung bình luận',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                      hintText: 'Bạn hãy nhập nội dung bình luận',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0)),
                    onPressed: () {
                      setState(() {
                        _comment.text = '';
                      });
                    },
                    child: const Text(
                      'Hủy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                    onPressed: () {
                      String comment = _comment.text.trim();
                      if (comment.length <= 10) {
                        Fluttertoast.showToast(
                            msg: "Nội dung bình luận ít nhất 10 kí tự",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor:
                                const Color.fromARGB(255, 214, 107, 25));
                      } else if (comment == '') {
                        Fluttertoast.showToast(
                            msg: "Nội dung bình luận không được trống",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor:
                                const Color.fromARGB(255, 214, 107, 25));
                      } else {
                        context.read<CommentManager>().addComment(
                            comment,
                            context.read<LoginService>().userId,
                            widget.productId);
                        Fluttertoast.showToast(
                            msg: "Bạn đã bình luận thành công",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor:
                                const Color.fromARGB(255, 35, 173, 0));
                      }
                    },
                    child: const Text(
                      'Gửi',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
