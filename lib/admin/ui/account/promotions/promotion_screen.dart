import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/admin/ui/account/promotions/promotion_manager.dart';
import 'package:mobile_app_3/client/models/promotion.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  bool selectedIndex = true;
  @override
  void initState() {
    super.initState();
    selectedIndex = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Áp khuyến mãi",
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 165,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              selectedIndex ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          side: BorderSide(
                              color:
                                  selectedIndex ? Colors.white : Colors.black),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedIndex = !selectedIndex;
                          });
                        },
                        child: Text(
                          "Xem tất cả",
                          style: TextStyle(
                            color: selectedIndex ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 165,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedIndex ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            side: BorderSide(
                                color: selectedIndex
                                    ? Colors.black
                                    : Colors.white)),
                        onPressed: () {
                          setState(() {
                            selectedIndex = !selectedIndex;
                          });
                        },
                        child: Text(
                          "Thêm khuyến mãi",
                          style: TextStyle(
                            color: selectedIndex ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              selectedIndex ? const PromotionsAll() : const AddPromotion()
            ],
          ),
        ),
      ),
    );
  }
}

class AddPromotion extends StatefulWidget {
  const AddPromotion({super.key});

  @override
  State<AddPromotion> createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDateBegin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null &&
        picked != selectedDate &&
        picked.isBefore(selectedDateEnd.add(const Duration(days: 0)))) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  DateTime selectedDateEnd = DateTime.now();

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateEnd,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null &&
        picked != selectedDateEnd &&
        picked.isAfter(selectedDate.subtract(const Duration(days: 1)))) {
      setState(() {
        selectedDateEnd = picked;
      });
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _condition = TextEditingController();
  final TextEditingController _info = TextEditingController();
  final TextEditingController _discount = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text = '';
    _info.text = '';
    _discount.text = '';
  }

  Future<void> _submit(PromotionModel promotion) async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    try {
      print(promotion.name +
          promotion.condition.toString() +
          promotion.end.toString());
      bool success =
          await context.read<PromotionManager>().addPromotion(promotion);

      if (!success) {
        await showErrorDialog(context, 'Thêm khuyến mãi không thành công');
      } else {
        await showSuccessDialog(context, 'Thêm khuyến mãi thành công');
      }
    } catch (error) {
      await showErrorDialog(context, "Lỗi không thêm được sản phẩm");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 43, 193, 29)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(
                          labelText: "Tên khuyến mãi",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Tên không được trống";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 43, 193, 29)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _info,
                        decoration: const InputDecoration(
                          labelText: "Nội dung khuyến mãi",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nội dung không được trống";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 43, 193, 29)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _condition,
                        decoration: const InputDecoration(
                          hintText: "Ví dụ: tổng tiền lớn hơn 20000000 (VND)",
                          labelText: "Điều kiện giảm",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Điều kiện giảm không được trống";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 43, 193, 29)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _discount,
                        decoration: const InputDecoration(
                          labelText: "Giá giảm",
                          hintText: "Ví dụ: 10 (%)",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Giá không được trống";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Ngày bắt đầu: ',
                                ),
                                Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => _selectDateBegin(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              child: const Text(
                                'Chọn',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Ngày kết thúc:',
                                ),
                                Text(
                                  '${selectedDateEnd.day}/${selectedDateEnd.month}/${selectedDateEnd.year}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => _selectDateEnd(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              child: const Text(
                                'Chọn',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 37, 143, 2)),
            onPressed: () {
              PromotionModel promotion = PromotionModel(
                  name: _name.text,
                  info: _info.text,
                  condition: int.parse(_condition.text),
                  discount: int.parse(_discount.text),
                  start: selectedDate,
                  end: selectedDateEnd);
              _submit(promotion);
            },
            child: const Text(
              "Lưu",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

class PromotionsAll extends StatefulWidget {
  const PromotionsAll({super.key});

  @override
  State<PromotionsAll> createState() => _PromotionsAllState();
}

class _PromotionsAllState extends State<PromotionsAll> {
  @override
  void initState() {
    super.initState();
    context.read<PromotionManager>().fetchPromotion();
  }

  Future<void> _removeOne(int id) async {
    // Sau khi xóa, gọi lại hàm fetchData để cập nhật giao diện
    context.read<PromotionManager>().removeOnePromotion(id);
  }

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<PromotionManager>(
          builder: (context, value, child) {
            if (value.itemAllPromotion.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.itemAllPromotion.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 251, 250, 250),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 23, 203, 235)
                                  .withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(3, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromARGB(
                                                255, 128, 210, 29),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              value
                                                  .itemAllPromotion[index].name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Giảm ${value.itemAllPromotion[index].discount}%",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      const Text(
                                        " cho đơn hàng từ ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "${_formatPrice(value.itemAllPromotion[index].condition.toString())} VND",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.sell,
                                      color: Colors.red,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      value.itemAllPromotion[index].info,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color:
                                              Color.fromARGB(255, 94, 94, 94)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${DateFormat('dd-MM-yyyy').format(value.itemAllPromotion[index].start)} - ${DateFormat('dd-MM-yyyy').format(value.itemAllPromotion[index].end)}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Bạn có chắn chắn xóa khuyến mãi này không?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            content: const Icon(
                                              Icons.warning,
                                              color: Colors.red,
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Hủy'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await _removeOne(value
                                                          .itemAllPromotion[
                                                              index]
                                                          .id!);
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Xác nhận'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Color.fromARGB(255, 66, 65, 65),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 221, 194, 194),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Không có khuyến mãi nào',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/image/promotion.jpg',
                          width: 300,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
