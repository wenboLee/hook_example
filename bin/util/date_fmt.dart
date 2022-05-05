import 'dart:io' as IO;

/// 日期格式化
class DateFmt {
  static String durationIndicatorBuilder(Duration duration) {
    IO.HttpDate date = IO.HttpDate();
    print('date = $date');

    const separator = ':';
    final minute = duration.inMinutes.toString().padLeft(2, '0');
    final second =
        ((duration - Duration(minutes: duration.inMinutes)).inSeconds)
            .toString()
            .padLeft(2, '0');
    return '$minute$separator$second';
  }
}
