import 'package:flutter/material.dart';

class TranSportScreen extends StatelessWidget {
  const TranSportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHÍNH SÁCH VẬN CHUYỂN',
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
      body: ListView(
        children: [
          Container(
            height: 200,
            width: screenWidth,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/image/icon_shipper.jpg'),
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MC - SHOP cam kết đem đến dịch vụ giao hàng nhanh chóng, đúng địa điểm cho toàn bộ đon hàng.'
                  ' Hiện tại MC - SHOP đang là đối tác lớn với đơn vị giao hàng có uy tín'
                  ' - GIAO HÀNG TIẾT KIỆM để hỗ trợ giao hàng trên toàn quốc và nước ngoài với chính sách cụ thể như sau: ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Thời gian giao hàng',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Table(
                  border: TableBorder.all(
                      color: const Color.fromARGB(255, 160, 159, 159)),
                  children: const [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            'Đối với nội thành Cần Thơ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            'Đối vơi ngoại thành',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            'Giao hỏa tốc trong vòng 4h và 24h đối với các đơn hàng đặt trước (Không tính chủ nhật và các ngày lễ Tết).',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Giao hàng trong 3-4 ngày (Không tính chủ nhật và các ngày lễ Tết).',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'Lưu ý: Thời gian có thể dao động từ 3 -5 ngày đối với các đợt sale lớn.',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const Text(
                  'Số lần giao hàng',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                  '– Shipper sẽ giao hàng tối đa 03 lần/đơn hàng.\n'
                  '– Trường hợp lần đầu giao hàng không thành công, Shipper sẽ liên hệ để sắp xếp lịch giao hàng lần 02 với bạn. Tổng cộng bạn có 03 lần để nhận đơn hàng.'
                  'Xin lưu ý: trong trường hợp chịu ảnh hưởng của thiên tai hoặc các sự kiện đặc biệt khác tác động không thể thay đổi thì chúng mình sẽ bảo lưu quyền thay đổi thời gian giao hàng mà không cần báo trước.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Kiểm tra tình trạng đơn hàng',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Bạn có thể truy cập vào “Đơn hàng của tôi” để kiểm tra trực tiếp tình trạng đơn hàng.\n'
                  'Hoặc kiểm tra với bộ phận chăm sóc khách hàng của MC - SHOP qua Fanpage FB/IG hoặc hotline: 0369951760 ',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
