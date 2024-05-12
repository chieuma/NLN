import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_3/client/models/config.dart';
import 'package:mobile_app_3/client/ui/product/config/config_manager.dart';
import 'package:mobile_app_3/client/ui/shared/showDialog.dart';
import 'package:provider/provider.dart';

class UpdateConfigScreen extends StatefulWidget {
  final ConfigModel config;
  const UpdateConfigScreen({required this.config, super.key});

  @override
  State<UpdateConfigScreen> createState() => _UpdateConfigScreenState();
}

class _UpdateConfigScreenState extends State<UpdateConfigScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _screen = TextEditingController();
  final TextEditingController _chip = TextEditingController();
  final TextEditingController _ram = TextEditingController();
  final TextEditingController _frontCamera = TextEditingController();
  final TextEditingController _rearCamera = TextEditingController();
  final TextEditingController _pin = TextEditingController();
  final TextEditingController _jackphone = TextEditingController();
  final TextEditingController _bluetooth = TextEditingController();
  final TextEditingController _opSystem = TextEditingController();

  @override
  void initState() {
    _screen.text = widget.config.screen!;
    _chip.text = widget.config.chip!;
    _ram.text = widget.config.ram!;
    _frontCamera.text = widget.config.frontCamera!;
    _rearCamera.text = widget.config.rearCamera!;
    _pin.text = widget.config.pin!;
    _jackphone.text = widget.config.jackPhone!;
    _bluetooth.text = widget.config.bluetooth!;
    _opSystem.text = widget.config.opSystem!;
  }

  Future<void> _submit(ConfigModel config) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool configSuccess =
          await context.read<ConfigManager>().updateConfig(config);
      if (!configSuccess) {
        await showErrorDialog(context, "Cập nhật không thành công");
      } else {
        showSuccessDialog(context, "Cập nhật thành công!");
      }
    } catch (error) {
      print(error);
      await showErrorDialog(context, "Lỗi");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cập nhật cấu hình",
          style: GoogleFonts.aBeeZee(),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ConfigManager>(builder: (context, configManager, child) {
              if (configManager.config.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: configManager.config.length,
                    itemBuilder: (context, index) {
                      ConfigModel config = configManager.config.first;
                      return Form(
                        key: _formKey,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8, top: 10),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _screen,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.fullscreen,
                                      size: 50,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Màn hình",
                                    hintText: "Ví dụ: OLED 16' inch",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _chip,
                                decoration: const InputDecoration(
                                    suffixIcon: Image(
                                      image:
                                          AssetImage('assets/image/chip.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Chip",
                                    hintText: "Ví dụ: M1",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _ram,
                                decoration: const InputDecoration(
                                    suffixIcon: Image(
                                      image: AssetImage('assets/image/ram.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "RAM",
                                    hintText: "Ví dụ: 8 (GB)",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _frontCamera,
                                decoration: const InputDecoration(
                                    suffixIcon: Image(
                                      image: AssetImage(
                                          'assets/image/front-camera.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Camera trước",
                                    hintText: "Ví dụ: 28 (MP)",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _rearCamera,
                                decoration: const InputDecoration(
                                    suffixIcon: Image(
                                      image:
                                          AssetImage('assets/image/rotate.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Camera sau",
                                    hintText: "Ví dụ: 46 (MP)",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _pin,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.battery_0_bar,
                                      size: 50,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Dung lượng pin",
                                    hintText: "Ví dụ: 5000 (mAh)",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _jackphone,
                                decoration: const InputDecoration(
                                    suffixIcon: Image(
                                      image: AssetImage(
                                          'assets/image/audio-jack.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Jack tai nghe",
                                    hintText: "Ví dụ: 3.5 (mm)",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _bluetooth,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.bluetooth,
                                      size: 50,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Bluetooh",
                                    hintText: "Ví dụ: 6.0",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shadowColor:
                                  const Color.fromARGB(255, 30, 211, 235),
                              elevation: 5,
                              child: TextFormField(
                                controller: _opSystem,
                                decoration: const InputDecoration(
                                    suffixIcon: Image(
                                      image: AssetImage(
                                          'assets/image/system-update.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    labelText: "Hệ điều hành",
                                    hintText: "Ví dụ: IOS",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Trường này không được trống";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  side: const BorderSide(
                                      width: 0.8, color: Colors.black),
                                ),
                                onPressed: () {
                                  initState();
                                },
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  side: const BorderSide(
                                      width: 0.8, color: Colors.black),
                                ),
                                onPressed: () {
                                  ConfigModel config = ConfigModel(
                                    screen: _screen.text,
                                    chip: _chip.text,
                                    ram: _ram.text,
                                    frontCamera: _frontCamera.text,
                                    rearCamera: _rearCamera.text,
                                    pin: _pin.text,
                                    jackPhone: _jackphone.text,
                                    bluetooth: _bluetooth.text,
                                    opSystem: _opSystem.text,
                                    pdId: widget.config.pdId,
                                  );
                                  // ignore: unrelated_type_equality_checks

                                  _submit(config);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => AddConfigScreen(
                                  //             productId: widget.productId)));
                                },
                                child: const Text(
                                  "Lưu",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ]),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
