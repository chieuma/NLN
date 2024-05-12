import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/ui/account/user/user_manager.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';
import 'package:mobile_app_3/client/ui/product/product_manager.dart';
import 'package:provider/provider.dart';

Future<bool?> showConfirmDialog(BuildContext context, String meesage) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.warning),
      title: const Text('Are you sure?'),
      content: Text(meesage),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ActionButton(
                actionText: 'Không',
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
            ),
            Expanded(
              child: ActionButton(
                actionText: 'Có',
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            )
          ],
        )
      ],
    ),
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.actionText,
    this.onPressed,
  });

  final String? actionText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(actionText ?? 'Ok', style: const TextStyle(fontSize: 16)),
    );
  }
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 30,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              message,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

Future<void> showSuccessDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(255, 2, 177, 78), fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

Future<void> showSuccessUpdateDialog(
    BuildContext context, String message, int pdId) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
                color: Color.fromARGB(255, 2, 177, 78), fontSize: 18),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            context.read<ProductDetailManager>().fetchPhoneDetail(pdId);
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}

Future<void> showCheckOrderDialog(
    BuildContext context, String message, int orderId) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          actionText: "Hủy",
        ),
        ActionButton(
          onPressed: () async {
            await context.read<OrderManager>().checkedOrder(orderId);

            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
            context.read<OrderManager>().fetchAllOrder();
            Fluttertoast.showToast(
                msg: "Đã xác nhận đơn hàng thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.green);
          },
        )
      ],
    ),
  );
}

// Future<bool?> showConfirmDelete(BuildContext context, String message,
//     ProductDetailModel color, int countColor, int productId) {
//   return showDialog(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       icon: const Icon(
//         Icons.warning,
//         color: Colors.red,
//       ),
//       content: Text(
//         message,
//         style: const TextStyle(fontSize: 16),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: ActionButton(
//                 actionText: 'Không',
//                 onPressed: () {
//                   Navigator.of(ctx).pop(false);
//                 },
//               ),
//             ),
//             Expanded(
//               child: ActionButton(
//                 actionText: 'Có',
//                 onPressed: () async {
//                   if (countColor > 1) {
//                     Navigator.of(ctx).pop(true);
//                     await context
//                         .read<ProductManager>()
//                         .removeProduct(color, countColor, productId);
//                     //   Navigator.pop(context);
//                     context
//                         .read<ProductDetailManager>()
//                         .fetchPhoneDetail(productId);
//                   } else {
//                     Navigator.of(ctx).pop(true);
//                     Navigator.pop(context);
//                     await context
//                         .read<ProductManager>()
//                         .removeProduct(color, countColor, productId);
//                     context.read<ProductManager>().fetchPhone();
//                   }
//                 },
//               ),
//             )
//           ],
//         )
//       ],
//     ),
//   );
// }
Future<bool?> showConfirmDelete(BuildContext context, String message,
    ProductDetailModel color, int countColor, int productId) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(
        Icons.warning,
        color: Colors.red,
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ActionButton(
                actionText: 'Không',
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
            ),
            Expanded(
              child: ActionButton(
                actionText: 'Có',
                onPressed: () async {
                  if (countColor > 1) {
                    Navigator.of(ctx).pop(true);
                    await context
                        .read<ProductManager>()
                        .removeProduct(color, countColor, productId);
                    //   Navigator.pop(context);
                    context
                        .read<ProductDetailManager>()
                        .fetchPhoneDetail(productId);
                  } else {
                    Navigator.of(ctx).pop(true);
                    Navigator.pop(context);
                    await context
                        .read<ProductManager>()
                        .removeProduct(color, countColor, productId);
                    context.read<ProductManager>().fetchPhone();
                  }
                },
              ),
            )
          ],
        )
      ],
    ),
  );
}

Future<void> showSuccessAddAccountDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(255, 2, 177, 78), fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop(true);
            Navigator.pop(context);
            context.read<UserManager>().fetchAllUser();
          },
        )
      ],
    ),
  );
}

Future<void> showSuccessAdd(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(255, 2, 177, 78), fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop(true);
            Navigator.pop(context);
            context.read<ProductManager>().fetchPhone();
          },
        )
      ],
    ),
  );
}
