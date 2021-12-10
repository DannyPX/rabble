import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

AsyncSnapshot<T> useMemoFuture<T>(Future<T> Function() future,
    {required T initialData, required List<Object?> keys}) {
  final memo = useMemoized(future, keys);
  return useFuture(memo, initialData: initialData);
}

T useDebounce<T>(T value, Duration delay) {
  final debouncedValue = useState(value);

  useEffect(() {
    final handler = Timer(delay, () => debouncedValue.value = value);
    return () => handler.cancel();
  }, [value, delay]);
  return debouncedValue.value;
}

String formatDuration(Duration d) {
  final totalSecs = d.inSeconds;
  final hours = totalSecs ~/ 3600;
  final minutes = (totalSecs % 3600) ~/ 60;
  final seconds = totalSecs % 60;
  final buffer = StringBuffer();

  if (hours > 0) {
    buffer.write('$hours:');
  }
  buffer.write('${minutes.toString().padLeft(2, '0')}:');
  buffer.write(seconds.toString().padLeft(2, '0'));
  return buffer.toString();
}
