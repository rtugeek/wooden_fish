import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wooden_fish/generated/assets.dart';

import '../settings/settings.dart';
import '../settings/settings_box.dart';

class WoodenFishLogic extends GetxController {
  List<AudioPlayer> players = [];
  List<String> audioPath = [];
  List<Widget> fadeOutUp = [];
  AnimationController? animationController;
  @override
  void onInit() {
    getTemporaryDirectory().then((tempDir) async {
      String tempPath = tempDir.path;
      for (int i = 0; i < 10; i++) {
        var file = File("$tempPath/hit_$i.mp3");
        if (!file.existsSync()) {
          ByteData data = await rootBundle.load(Assets.audioHit);
          List<int> bytes =
              data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await file.writeAsBytes(bytes);
        }
        var audioPlayer = AudioPlayer(playerId: "player$i");
        audioPlayer.setReleaseMode(ReleaseMode.release);
        audioPlayer.onPlayerComplete.asBroadcastStream().listen((event) {
          //手动切换为停止状态
          audioPlayer.stop();
        });

        audioPath.add(file.path);
        players.add(audioPlayer);
      }
    });
  }

  hit() {
    for (int i = 0; i < players.length; i++) {
      var player = players[i];
      if (player.state == PlayerState.completed ||
          player.state == PlayerState.stopped) {
        player.play(DeviceFileSource(audioPath[i]));
        break;
      }
    }
    if(_settings.text.isNotEmpty) {
      fadeOutUp.add(_buildFadeOutUpWidget());
    }
    animationController?.forward(from: 0);
    update(["fadeOutUp"]);
  }

  Timer? _timer;
  late Settings _settings;
  updateSettings(Settings settings) {
    _settings = settings;
    if (settings.auto) {
      _timer?.cancel();
      _timer =
          Timer.periodic(Duration(milliseconds: settings.interval), (timer) {
        hit();
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Widget _buildFadeOutUpWidget() {
    return Padding(
      key: ObjectKey(DateTime.now()),
      padding: const EdgeInsets.only(top: 100,right: 32),
      child: FadeOutUp(
          controller: (c) {
            c.forward();
            c.addStatusListener((status) {
              fadeOutUp.removeAt(0);
            });
          },
          duration: Duration(seconds: 2),
          child: Text(
            "${_settings.text}+1",
            style: const TextStyle(color: Colors.white, fontSize: 32),
          )),
    );
  }
}
