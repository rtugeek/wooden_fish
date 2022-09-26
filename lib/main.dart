import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wooden_fish/componet/clickable.dart';
import 'package:wooden_fish/settings/settings_box.dart';
import 'package:wooden_fish/settings/settings_view.dart';
import 'package:wooden_fish/wooden_fish/wooden_fish_view.dart';
import 'dart:io';

import 'generated/assets.dart';

void main() async {
  await Hive.initFlutter();
  await SettingsBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/settings", page: () => SettingsPage()),
        GetPage(name: "/", page: () => const MyHomePage())
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, c) {
        var maxWidth = c.maxWidth;
        var maxHeight = c.maxHeight;
        var size = min(maxWidth, maxHeight);
        size = size > 1000 ? 1000 : size;
        return Container(
          width: double.infinity,
          color: Colors.black,
          child: SafeArea(
            child: Stack(
              children: [
                Clickable(
                  onTap: () async {
                    await Get.toNamed("/settings");
                    setState(() {});
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.settings, color: Colors.white)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: WoodenFishPage(
                    size: size,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
