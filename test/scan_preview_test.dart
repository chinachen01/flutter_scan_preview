import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scan_preview/scan_preview.dart';

void main() {
  const MethodChannel channel = MethodChannel('scan_preview');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
