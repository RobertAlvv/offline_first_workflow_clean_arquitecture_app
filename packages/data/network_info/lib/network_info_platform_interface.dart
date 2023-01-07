import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'network_info_method_channel.dart';

abstract class NetworkInfoPlatform extends PlatformInterface {
  /// Constructs a NetworkInfoPlatform.
  NetworkInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkInfoPlatform _instance = MethodChannelNetworkInfo();

  /// The default instance of [NetworkInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelNetworkInfo].
  static NetworkInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NetworkInfoPlatform] when
  /// they register themselves.
  static set instance(NetworkInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
