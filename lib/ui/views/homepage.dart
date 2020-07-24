import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scan_shot/ui/widgets/mainPage_widget.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';

const SCANBOT_SDK_LICENSE_KEY = "hlY6QItRuJ6+meD//LDIjelN0NqU+H" +
    "cplkQsgNm55xotlUBz6+sxWktnESRI" +
    "PC821cObco0WaLCQk5LeFKQzjg2jME" +
    "UJ6Wz77/rjAqVp6sQl2lsZQP/vuorn" +
    "5nowPAHI3JkzZRtnIyxi5pYaX7oqsB" +
    "uB+yRZF6oftCUzLw2g0kN1MM/sBEuM" +
    "hgUHCMEB/yf5H48NvpxbKdTPgz6I4e" +
    "ayk745T0Vsl+yFxSRt7xsMsNrOMgK4" +
    "MEsjpspJt8qFtKGu7yuD/ct9v2sUz2" +
    "Fsr7/nJLG68pJ4Qne9q585F9wHYWHf" +
    "rBBmMxk+ktoUgxzFkK7JEFB41nkVNL" +
    "s+5Xjw8Kt4Jw==\nU2NhbmJvdFNESw" +
    "pjb20uZXhhbXBsZS5zY2FuX3Nob3QK" +
    "MTU5ODE0MDc5OQo1OTAKMw==\n";

initScanbotSdk() async {
  var config = ScanbotSdkConfig(
    loggingEnabled: false,
    licenseKey: SCANBOT_SDK_LICENSE_KEY,
    imageFormat: ImageFormat.JPG,
    imageQuality: 80,
  );

  try {
    await ScanbotSdk.initScanbotSdk(config);
  } catch (e) {
    print(e);
  }
}

Future<String> getDemoStorageBaseDirectory() async {
  Directory storageDirectory;
  if (Platform.isAndroid) {
    storageDirectory = await getExternalStorageDirectory();
  } else if (Platform.isIOS) {
    storageDirectory = await getApplicationDocumentsDirectory();
  } else {
    throw ("Unsupported platform");
  }

  return "${storageDirectory.path}/my-custom-storage";
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    initScanbotSdk();

    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageUI(),
    );
  }
}
