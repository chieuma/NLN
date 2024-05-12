import 'package:flutter/material.dart';
import 'package:mobile_app_3/admin/ui/product/product_screen.dart';
import 'package:mobile_app_3/admin/ui/account/account_screen.dart';
import 'package:mobile_app_3/admin/ui/home/home_screen.dart';
import 'package:mobile_app_3/admin/ui/statistical/statistical_screen.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/admin/ui/order/order_screen.dart';

import 'package:provider/provider.dart';

class BottomNavigationModelAdmin extends ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class BottomNavigationAdmin extends StatefulWidget {
  const BottomNavigationAdmin({super.key, String? userId});

  @override
  State<BottomNavigationAdmin> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigationAdmin> {
  @override
  void initState() {
    super.initState();
    final loginService = Provider.of<LoginService>(context, listen: false);
    loginService.onLogout = () {
      Provider.of<BottomNavigationModelAdmin>(context, listen: false)
          .setSelectedIndex(0);
    };
  }

  String selectedPage = '';
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModelAdmin =
        Provider.of<BottomNavigationModelAdmin>(context);
    return Scaffold(
      body: IndexedStack(
        index: bottomNavigationModelAdmin.selectedIndex,
        children: const [
          HomeScreen(),
          ProductScreen(),
          StatisticalScreen(),
          OrderScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationModelAdmin.selectedIndex,
        onTap: (index) {
          bottomNavigationModelAdmin.setSelectedIndex(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Sản phẩm',
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.pink),
            label: 'Thống kê',
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            label: 'Đơn hàng',
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Tài khoản',
            backgroundColor: Colors.black,
          ),
        ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
