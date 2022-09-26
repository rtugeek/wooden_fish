import 'package:hive/hive.dart';

import 'settings.dart';

class SettingsBox {
  static late Box<Settings> box;

  static init() async {
    Hive.registerAdapter(SettingsAdapter());
    box = await Hive.openBox<Settings>('settingsBox');
  }

  static Settings get() {
   return box.get("settings",defaultValue: Settings())!;
  }
}
