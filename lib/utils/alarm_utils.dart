import 'package:alarm/alarm.dart';

class AlarmUtils {
  static int morningAlarmId = 40;
  static int afternoonAlarmId = 41;

  static void setAlarm(int id, DateTime datetime, String title, String body) async {
    final alarmSettings = AlarmSettings(
      id: id,
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

  static void stopAllAlarm() async {
    await Alarm.stop(morningAlarmId);
    await Alarm.stop(afternoonAlarmId);
  }
}