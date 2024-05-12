import 'package:flutter/material.dart';

class WarrantyScreen extends StatelessWidget {
  const WarrantyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CHÍNH SÁCH BẢO HÀNH",
          style: TextStyle(fontWeight: FontWeight.w700),
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
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 140,
                width: screenWidth,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/image_system/OIP.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              '   MC - SHOP xin lỗi vì sự cố các thiết bị điện tử của quý khách'
              ' bị hỏng và phải đi bảo hành. MC - SHOP có 2 hỗ trợ dành rieng cho khách hàng mua'
              ' đồ điện tử tại shop như sau:',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '   MC - SHOP sẽ cung cấp cho khách hàng một thiết bị điện tử khác đã qua sử dụng '
              'để khách hàng sử dụng tạm thời.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '   Bảo hành 12 tháng nếu máy đi bảo hành quá 15 ngày hãng chưa trả máy cho khách hàng'
              ' hoặc phải bảo hành lại một lần nữa trong 30 ngày kể từ làn bảo hành trước'
              ', khách hàng được áp dụng phương thức hư gì đổi nấy ngay và luôn hoặc hoàn tiền với mức phí giảm 50%. '
              'Lưu ý: Chỉ áp dụng cho điện thoại và phải còn trong điều kiện bảo hành.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
