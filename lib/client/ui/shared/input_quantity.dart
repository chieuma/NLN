import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_3/client/services/login_service.dart';
import 'package:mobile_app_3/client/ui/cart/cart_manager.dart';

import 'package:provider/provider.dart';

class InputQty extends StatefulWidget {
  final int maxVal;
  final int initVal;
  final int minVal;
  final int steps;

  const InputQty({
    Key? key,
    required this.maxVal,
    required this.initVal,
    required this.minVal,
    required this.steps,
  }) : super(key: key);

  @override
  State<InputQty> createState() => InputQtyState();
}

class InputQtyState extends State<InputQty> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initVal;
  }

  int getValue() {
    return _value;
  }

  void _increment() {
    setState(() {
      if (_value + widget.steps <= widget.maxVal) {
        _value += widget.steps;
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_value - widget.steps >= widget.minVal) {
        _value -= widget.steps;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 40,
      child: TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _value < widget.minVal || _value > widget.maxVal
              ? Colors.red
              : Colors.black, // Thay đổi màu chữ
          fontWeight: FontWeight.w600,
        ),
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 3),
          suffixIcon: IconButton(
            onPressed: _increment,
            icon: const Icon(Icons.add),
          ),
          prefixIcon: IconButton(
            onPressed: _decrement,
            icon: const Icon(Icons.remove),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 237, 217, 217),
          border: InputBorder.none,
        ),
        controller: TextEditingController(text: '${_value}'),
      ),
    );
  }
}

class InputQtyTT extends StatefulWidget {
  final int maxVal;
  final int initVal;
  final int minVal;
  final int steps;
  final int cartId;
  final Function(int, int) onQuantityChanged;

  const InputQtyTT({
    Key? key,
    required this.maxVal,
    required this.initVal,
    required this.minVal,
    required this.steps,
    required this.cartId,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  State<InputQtyTT> createState() => _InputQtyTTState();
}

class _InputQtyTTState extends State<InputQtyTT> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initVal;
  }

  void _increment() {
    setState(() {
      if (_value + widget.steps <= widget.maxVal) {
        _value += widget.steps;
        widget.onQuantityChanged(
            widget.cartId, _value); // Thông báo số lượng mới
      }
    });
    // context.read<CartManager>().updateQuantity(
    //     widget.cartId, _value, context.read<LoginService>().userId);
  }

  void _decrement() {
    setState(() {
      if (_value - widget.steps >= widget.minVal) {
        _value -= widget.steps;
        widget.onQuantityChanged(
            widget.cartId, _value); // Thông báo số lượng mới
      }
    });
    // context.read<CartManager>().updateQuantity(
    //     widget.cartId, _value, context.read<LoginService>().userId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 40,
      child: Consumer<CartManager>(builder: (context, value, child) {
        return TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _value < widget.minVal || _value > widget.maxVal
                ? Colors.red
                : Colors.black, // Thay đổi màu chữ
            fontWeight: FontWeight.w600,
          ),
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 3),
            suffixIcon: IconButton(
              onPressed: _increment,
              icon: const Icon(Icons.add),
            ),
            prefixIcon: IconButton(
              onPressed: _decrement,
              icon: const Icon(Icons.remove),
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 237, 217, 217),
            border: InputBorder.none,
          ),
          controller: TextEditingController(text: '${_value}'),
        );
      }),
      // child: TextFormField(
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     color: _value < widget.minVal || _value > widget.maxVal
      //         ? Colors.red
      //         : Colors.black, // Thay đổi màu chữ
      //     fontWeight: FontWeight.w600,
      //   ),
      //   readOnly: true,
      //   decoration: InputDecoration(
      //     contentPadding: EdgeInsets.symmetric(vertical: 3),
      //     suffixIcon: IconButton(
      //       onPressed: _increment,
      //       icon: const Icon(Icons.add),
      //     ),
      //     prefixIcon: IconButton(
      //       onPressed: _decrement,
      //       icon: const Icon(Icons.remove),
      //     ),
      //     filled: true,
      //     fillColor: const Color.fromARGB(255, 237, 217, 217),
      //     border: InputBorder.none,
      //   ),
      //   controller: TextEditingController(text: '${_value}'),
      // ),
    );
  }
}
