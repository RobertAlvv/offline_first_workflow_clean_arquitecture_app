import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_info/network_info_method_channel.dart';

void main() {
  MethodChannelNetworkInfo platform = MethodChannelNetworkInfo();
  const MethodChannel channel = MethodChannel('network_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
