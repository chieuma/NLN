import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_3/client/ui/cart/cart_manager.dart';
import 'package:mobile_app_3/client/ui/shared/top_right_badge.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app_3/client/models/favorite.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:mobile_app_3/client/ui/favorite/favorite_manager.dart';
import 'package:mobile_app_3/client/ui/product/phone_detail_screen.dart';
import 'package:mobile_app_3/client/ui/shared/color.dart';
import 'package:mobile_app_3/client/ui/shop/shop_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  void _fetchFavorites() {
    context
        .read<FavoriteManager>()
        .fetchFavorite(context.read<LoginService>().userId);
  }

  Future<void> _removeAllItem() async {
    // Sau khi xóa, gọi lại hàm fetchData để cập nhật giao diện
    int? userId = context.read<LoginService>().userId;
    context.read<FavoriteManager>().removeAllItem(userId);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'YÊU THÍCH',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                shadowColor: Colors.black,
                elevation: 4,
                actions: [
                  Consumer<CartManager>(
                    builder: (context, value, child) {
                      return TopRightBadge(
                        data: value.countItem(),
                        child: IconButton(
                          onPressed: () {
                            bottomNavigationModel.setSelectedIndex(3);
                          },
                          icon: const Icon(
                            Icons.shopping_bag,
                            color: Color.fromARGB(255, 255, 0, 204),
                          ),
                        ),
                      );
                    },
                  ),
                  PopupMenuButton(
                    color: const Color.fromARGB(221, 0, 0, 0),
                    iconColor: Colors.black,
                    onSelected: (value) => (),
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Chọn tất cả',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Bạn có chắn chắn xóa các sản phẩm yêu thích?',
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
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Hủy'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _removeAllItem();
                                            Navigator.of(context)
                                                .pop(); // Đóng alert
                                            Navigator.pop(
                                                ctx); // Đóng hộp thoại showdialog
                                          },
                                          child: const Text('Xác nhận'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Xóa tất cả',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<FavoriteManager>(
                      builder: (context, fav, child) {
                        if (fav.favorite.isNotEmpty) {
                          return Column(
                            children: fav.favorite.map(
                              (favorite) {
                                return PhoneScreen(fetchPhone: favorite);
                              },
                            ).toList(),
                          );
                        } else {
                          return const FavNoItemScreen();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PhoneScreen extends StatelessWidget {
  final FavoriteModel fetchPhone;
  const PhoneScreen({
    required this.fetchPhone,
    super.key,
  });

  @override
  String _formatPrice(String price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(double.parse(price));
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PhoneDetailScreen(productId: fetchPhone.productId),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    title: Text(
                      fetchPhone.productName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.memory(
                            fetchPhone.imageUrls[0],
                            //fit: BoxFit.cover,
                            width: 220,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Màu ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  for (var color in fetchPhone.colorName)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        decoration: BoxDecoration(
                                          color: getColorFromString(color),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text(
                                //   "GB   ",
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Wrap(
                                  children: [
                                    for (var gb in fetchPhone.memoryOptions)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          '${gb}GB',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color:
                                            Color.fromARGB(255, 248, 219, 89)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '${_formatPrice(fetchPhone.priceOptions[0])}₫',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavNoItemScreen extends StatefulWidget {
  const FavNoItemScreen({super.key});

  @override
  State<FavNoItemScreen> createState() => _FavNoItemScreenState();
}

class _FavNoItemScreenState extends State<FavNoItemScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _navigateToHome() {
    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const ShopScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Column(
      children: [
        const SizedBox(height: 240),
        const Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hiện tại bạn không có sản phẩm yêu thích nào',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(
          height: 260,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    bottomNavigationModel.setSelectedIndex(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Yêu Thích Ngay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
