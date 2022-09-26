import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  final logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("设置")),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.blue.shade100.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: FormField(builder: (s) {
          var titleStyle = Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold);
          return GetBuilder<SettingsLogic>(
            assignId: true,
            builder: (logic) {
              return Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "自动模式",
                        style: titleStyle,
                      ),
                      const Spacer(),
                      Switch(
                          value: logic.settings.auto,
                          onChanged: (bool value) {
                            logic.updateAuto(value);
                          })
                    ],
                  ),
                  TextFormField(
                    maxLength: 20,
                    controller: logic.textEditingController,
                    decoration: const InputDecoration(labelText: "悬浮文字"),
                  ),
                  if (logic.settings.auto)
                    Text(
                      "敲击间隔：${logic.settings.interval / 1000}S",
                      style: titleStyle,
                    ),
                  if (logic.settings.auto)
                    Slider(
                        value: logic.settings.interval / 1000.0,
                        min: 0.2,
                        max: 3,
                        onChanged: (double value) {
                          logic.updateInterval(value);
                        })
                ],
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logic.save();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
