import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/services/login_service.dart';

import 'package:provider/provider.dart';

import '../home/home_srceen.dart';
import '../cart/cart_screen.dart';
import '../shop/shop_screen.dart';
import '../favorite/favorite_screen.dart';
import '../account/account_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, String? userId});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    final loginService = Provider.of<LoginService>(context, listen: false);
    loginService.onLogout = () {
      Provider.of<BottomNavigationModel>(context, listen: false)
          .setSelectedIndex(0);
    };
  }

  String selectedPage = '';
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Scaffold(
      body: IndexedStack(
        index: bottomNavigationModel.selectedIndex,
        children: const [
          HomeScreen(),
          ShopScreen(),
          FavoriteScreen(),
          CartScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationModel.selectedIndex,
        onTap: (index) {
          bottomNavigationModel.setSelectedIndex(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Shop',
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.pink),
            label: 'Yêu thích',
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
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
