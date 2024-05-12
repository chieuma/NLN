import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/config.dart';
import 'package:mobile_app_3/client/ui/product/config/config_manager.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfigScreen extends StatefulWidget {
  late int productId;
  ConfigScreen({required this.productId, super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool isExpanded1 = true;
  @override
  void initState() {
    super.initState();
    context.read<ConfigManager>().fetchConfig(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigManager>(builder: (context, configManager, child) {
      if (configManager.config.isNotEmpty) {
        ConfigModel config = configManager.config.first;
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded1 = !isExpanded1;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cấu hình chung',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Icon(isExpanded1
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up),
                  ],
                ),
              ),
              if (isExpanded1)
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.5), // Cột thứ nhất chiếm 1 phần
                    1: FlexColumnWidth(1), // Cột thứ hai chiếm 2 phần
                  },
                  children: [
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Màn hình:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            config.screen!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Chip:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            config.chip!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'RAM:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            "${config.ram!} GB",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Camera trước:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            '${config.frontCamera!} MP',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Camera sau:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            "${config.rearCamera!} MP",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Pin, Sạc:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            "${config.pin!} mAh",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Jack Tai nghe',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            config.jackPhone!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Bluetooth',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            config.bluetooth!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          'Hệ điều hành:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        TableCell(
                          child: Text(
                            config.opSystem!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      } else {
        return const Center(
          child: Text(
            "Chưa có cấu hình chi tiết",
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    });
  }
}
