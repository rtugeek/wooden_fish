import 'package:hive/hive.dart';

part 'settings.g.dart';
@HiveType(typeId: 1)
class Settings extends HiveObject{
  //单位毫秒
  @HiveField(0,defaultValue: 500)
  int interval;
  @HiveField(1,defaultValue: true)
  bool auto;
  @HiveField(2,defaultValue: "功德")
  String text;

  Settings({this.interval = 500, this.auto = true, this.text = "功德"});
}
