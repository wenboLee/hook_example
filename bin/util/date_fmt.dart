import 'dart:io' as dart_io;

class DateFmt {
  static String durationIndicatorBuilder(Duration duration) {
    dart_io.HttpDate date = dart_io.HttpDate();
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
