import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/admin/ui/account/promotions/promotion_manager.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/models/order_1item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_3/client/models/promotion.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/order/order_detail_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:provider/provider.dart';

class Payment1ItemScreen extends StatefulWidget {
  final Order1ItemModel payment1item;
  const Payment1ItemScreen({required this.payment1item, Key? key})
      : super(key: key);

  @override
  State<Payment1ItemScreen> createState() => Payment1ItemScreenState();
}

class Payment1ItemScreenState extends State<Payment1ItemScreen> {
  // controller text
  final TextEditingController _name = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();

  //promotion
  int discount = 0;
  int _selectedPromotion = 0;
  int condition = 0;
  double total = 0.0;

  bool isChecked = false;
  bool isCheckedCS = false;
  String selectedRadioPayment = '';
  // Radio
  String selectedRadio = '';

  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  @override
  void initState() {
    super.initState();
    _totalPrice(widget.payment1item.quantity, widget.payment1item.price, 0, 0);
    context.read<PromotionManager>().fetchPromotion();
  }

  Future<double> _totalPrice(
      int quantity, int price, int discount, int condition) async {
    total = (quantity * price).toDouble();
    if (total >= condition.toDouble()) {
      total =
          context.read<OrderManager>().totalOneItem(quantity, price, discount);
    }
    return total;
  }

  Future<void> fetch() async {
    context
        .read<OrderManager>()
        .fetchOrder(context.read<LoginService>().userId);
    context
        .read<OrderDetailManager>()
        .fetchOrderDetail(context.read<LoginService>().userId);

    context.read<PromotionManager>().fetchPromotion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "THANH TOÁN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [],
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(0.5),
                  2: FlexColumnWidth(0.6),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Column(
                          children: [
                            Image(
                              image:
                                  MemoryImage((widget.payment1item.imageUrl!)),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.payment1item.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.payment1item.memory}GB',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Màu: ${widget.payment1item.colorVn}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.blue),
                            ),
                            Text(
                              'Só lượng: ${widget.payment1item.quantity}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 13, 66, 110)),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatPrice(
                                  (widget.payment1item.price).toString()),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              '₫',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Color.fromARGB(255, 133, 133, 133),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'THÔNG TIN KHÁCH HÀNG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(children: [
                  RadioListTile<String>(
                      activeColor: Colors.green,
                      title: const Text('Anh'),
                      value: '1',
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = value!;
                        });
                      }),
                  RadioListTile<String>(
                      activeColor: Colors.green,
                      title: const Text('Chị'),
                      value: '2',
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = value!;
                        });
                      }),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(
                            labelText: 'Họ và tên',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: 'Họ và Tên',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange))),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        controller: _tel,
                        decoration: const InputDecoration(
                          labelText: 'Số điện thoại',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Số điện thoại',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Địa chỉ nhận hàng",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _address,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Áp khuyến mãi",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Consumer<PromotionManager>(
                      builder: (context, value, child) {
                        if (value.itemAllPromotion.isNotEmpty) {
                          List<DropdownMenuItem<int>> dropdownItems = [];
                          for (int i = 0;
                              i < value.itemAllPromotion.length;
                              i++) {
                            PromotionModel promotion =
                                value.itemAllPromotion[i];
                            condition = promotion.condition;
                            discount = promotion.discount;
                            dropdownItems.add(
                              DropdownMenuItem(
                                value: i,
                                child: Text(
                                  "Giảm giá ${promotion.discount.toString()}% cho đơn hàng từ ${promotion.condition.toString()} VND",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }
                          return DropdownButton<int>(
                            value: _selectedPromotion,
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor:
                                const Color.fromARGB(255, 233, 221, 221),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            items: dropdownItems,
                            onChanged: (int? selectedIndex) {
                              setState(() {
                                _selectedPromotion = selectedIndex!;
                                PromotionModel selectedPromotion =
                                    value.itemAllPromotion[selectedIndex];

                                // Cập nhật giá trị discount và condition với thông tin mới từ promotion được chọn
                                discount = selectedPromotion.discount;
                                condition = selectedPromotion.condition;
                                _totalPrice(
                                    widget.payment1item.quantity,
                                    widget.payment1item.price,
                                    discount,
                                    condition);
                              });
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("Không có khuyến mãi nào"),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Hình thức thanh toán",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    RadioListTile<String>(
                      activeColor: Colors.green,
                      title: Text(
                        'Thanh toán khi nhận hàng',
                        style: TextStyle(
                          color: selectedRadioPayment == '1'
                              ? const Color.fromARGB(255, 4, 161, 9)
                              : Colors.black,
                        ),
                      ),
                      value: '1',
                      groupValue: selectedRadioPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioPayment = value!;
                        });
                      },
                      secondary: Image.asset(
                        'assets/icon/money.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    RadioListTile<String>(
                      activeColor: Colors.green,
                      title: Text(
                        'Thanh toán bằng ví MoMo',
                        style: TextStyle(
                          color: selectedRadioPayment == '2'
                              ? const Color.fromARGB(255, 4, 161, 9)
                              : Colors.black,
                        ),
                      ),
                      value: '2',
                      groupValue: selectedRadioPayment,
                      onChanged: (value) {
                        setState(
                          () {
                            selectedRadioPayment = value!;
                          },
                        );
                      },
                      secondary: Image.asset(
                        'assets/icon/momo.png',
                        width: 55,
                        height: 55,
                      ),
                    ),
                    RadioListTile<String>(
                      activeColor: Colors.green,
                      title: Text(
                        'Thanh toán bằng ZaloPay',
                        style: TextStyle(
                          color: selectedRadioPayment == '3'
                              ? const Color.fromARGB(255, 4, 161, 9)
                              : Colors.black,
                        ),
                      ),
                      value: '3',
                      groupValue: selectedRadioPayment,
                      onChanged: (value) {
                        setState(
                          () {
                            selectedRadioPayment = value!;
                          },
                        );
                      },
                      secondary: Image.asset(
                        'assets/icon/zalo_pay.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Tổng tiền: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _formatPrice(total.toString()),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '₫',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isCheckedCS,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedCS = value!;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Tôi đồng ý với ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'chính sách quản lý dữ liệu cá nhân',
                                  style: TextStyle(
                                    color: Colors.blue, // Đổi màu của phần này
                                    fontWeight: FontWeight
                                        .bold, // Các thuộc tính khác nếu cần
                                  ),
                                ),
                                TextSpan(
                                  text: ' của MC - SHOP',
                                  // Các thuộc tính cho phần còn lại của văn bản
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextButton(
                    onPressed: () {
                      OrderModel order = OrderModel(
                        userId: context.read<LoginService>().userId,
                        name: _name.text,
                        address: _address.text,
                        tel: _tel.text,
                        email: _email.text,
                        total: total,
                      );

                      context
                          .read<ProductDetailManager>()
                          .add1Order(order, widget.payment1item);
                      // fetch();
                      context
                          .read<OrderManager>()
                          .fetchOrder(context.read<LoginService>().userId);
                      context.read<OrderDetailManager>().fetchOrderDetail(
                          context.read<LoginService>().userId);
                      Fluttertoast.showToast(
                          msg: "Quý khách đã đặt hàng thành công",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.green);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Đặt độ cong ở đây
                        ),
                      ),
                    ),
                    child: const Text(
                      'ĐẶT HÀNG',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
