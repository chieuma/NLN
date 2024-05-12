import 'package:flutter/material.dart';
import 'package:mobile_app_3/admin/ui/account/promotions/promotion_manager.dart';
import 'package:mobile_app_3/admin/ui/statistical/statistical_manager.dart';
import 'package:mobile_app_3/admin/ui/bottomnavigation/bottomnavigation.dart';
import 'package:mobile_app_3/client/services/signup_service.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_detail_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';

import 'package:mobile_app_3/client/ui/product/comment/comment_manager.dart';
import 'package:mobile_app_3/client/ui/product/config/config_manager.dart';

import 'package:mobile_app_3/client/ui/shop/brand_manager.dart';
import 'package:mobile_app_3/client/ui/search/search_manager.dart';
import 'package:mobile_app_3/public/intro_screen.dart';

import 'package:provider/provider.dart';
import './client/ui/bottomnavigation/bottomnavigation_screen.dart';
import './client/services/login_service.dart';
import './public/login_screen.dart';
import './client/ui/shop/category_manager.dart';
import './client/ui/cart/cart_manager.dart';
import './client/ui/favorite/favorite_manager.dart';
import './client/ui/product/product_detail_manager.dart';
import './client/ui/product/product_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BottomNavigationModelAdmin(),
            child: const BottomNavigationAdmin(),
          ),
          ChangeNotifierProvider(
            create: (context) => BottomNavigationModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginService(),
            child: const Login(),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoryManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductDetailManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => ConfigManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderDetailManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => BrandManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => CommentManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => StatisticalManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => SignUpService(),
          ),
          ChangeNotifierProvider(
            create: (context) => PromotionManager(),
          ),
        ],
        child: const AppWrapper(),
      ),
    );
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginService>(
      builder: (context, loginModel, child) {
        if (loginModel.isLoggedIn) {
          if (loginModel.userRole == 'admin' ||
              loginModel.userRole == 'staff') {
            return const BottomNavigationAdmin();
          } else {
            return const BottomNavigation();
          }
        } else {
          //return const Login();
          return const IntroScreen();
        }
      },
    );
  }
}
