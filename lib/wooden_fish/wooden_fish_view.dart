import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:wooden_fish/settings/settings_box.dart';

import '../generated/assets.dart';
import '../settings/settings.dart';
import 'wooden_fish_logic.dart';

class WoodenFishPage extends StatelessWidget {
  final double size;
  final logic = Get.put(WoodenFishLogic());

  WoodenFishPage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settings = SettingsBox.get();
    logic.updateSettings(settings);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: GestureDetector(
              onTap: () {
                if (!settings.auto) logic.hit();
              },
              child: Pulse(
                animate: false,
                controller: (c) {
                  logic.animationController = c;
                },
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: SvgPicture.asset(
                    Assets.imagesWoodenFish,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GetBuilder<WoodenFishLogic>(
                id: "fadeOutUp",
                builder: (logic) {
                  return Stack(
                    children: [
                      ...logic.fadeOutUp,
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
