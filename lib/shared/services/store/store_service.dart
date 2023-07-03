import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class StoreService {
  static void launchStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? '' : '1644035976';
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
