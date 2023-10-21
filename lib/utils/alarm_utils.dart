import 'package:alarm/alarm.dart';

int alarmCount = 0;

class AlarmUtils {
  static void setAlarm(DateTime datetime, String title, String body) async {
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: datetime,
      assetAudioPath: 'assets/audio/alarm.wav',
      loopAudio: true,
      vibrate: true,
      volumeMax: true,
      fadeDuration: 3.0,
      notificationTitle: title,
      notificationBody: body,
      enableNotificationOnKill: false,
      stopOnNotificationOpen: true
    );

    await Alarm.set(alarmSettings: alarmSettings);
  }

  static void stopAlarm() async {
    await Alarm.stop(42);
  }
}