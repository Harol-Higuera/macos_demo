
import 'package:flutter/services.dart';

import 'window_to_front_platform_interface.dart';

class WindowToFront {

  static const MethodChannel methodChannel = MethodChannel('window_to_front');

  static Future<void> activate() {
    return methodChannel.invokeMethod('active');
  }

  Future<String?> getPlatformVersion() {
    return WindowToFrontPlatform.instance.getPlatformVersion();
  }
}
