import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooden_fish/settings/settings.dart';

import 'settings_box.dart';

class SettingsLogic extends GetxController {
  Settings settings = SettingsBox.get();
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    textEditingController.text = settings.text;
  }

  save() {
    settings.text = textEditingController.value.text;
    settings.save();
    Get.back(result: settings);
  }

  void updateInterval(double value) {
    var valueInMills = value * 1000;
    settings.interval = valueInMills ~/ 100 * 100;
    update();
  }

  void updateAuto(bool value) {
    settings.auto = value;
    update();
  }
}
