import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scan_shot/core/viewmodels/auth_service.dart';
import 'package:scan_shot/ui/scan_ui/preview_document_widget.dart';
import 'package:scan_shot/ui/scan_ui/progress_dialog.dart';
import 'package:scan_shot/core/services/utils.dart';
import 'package:scan_shot/ui/shared/appBar_textStyle.dart';
import 'package:scan_shot/ui/widgets/card_item.dart';
import 'package:scanbot_sdk/barcode_scanning_data.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/mrz_scanning_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';

import '../../core/models/pages_repository.dart';

class MainPageUI extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageUI> {
  PageRepository _pageRepository = PageRepository();

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20.0,
              color: Colors.black,
            ),
            onPressed: () {
              auth.signOutGoogle();
              print('Signed out');
            },
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'ScanShot',
          style: AppBarTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Cards("Start Scaning", onTap: () {
                startDocumentScanning();
              }),
              Cards("Import Image", onTap: () {
                importImage();
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Cards(
                "View Image Results",
                endIcon: Icons.keyboard_arrow_right,
                onTap: () {
                  gotoImagesView();
                },
              ),
              Cards(
                "Scan Barcode (all formats: 1D + 2D)",
                onTap: () {
                  startBarcodeScanner();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Cards(
                "Scan QR code (QR format only)",
                onTap: () {
                  startQRScanner();
                },
              ),
              Cards(
                "Scan MRZ (Machine Readable Zone)",
                onTap: () {
                  startMRZScanner();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  getOcrConfigs() async {
    try {
      var result = await ScanbotSdk.getOcrConfigs();
      showAlertDialog(context, jsonEncode(result), title: "OCR Configs");
    } catch (e) {
      print(e);
      showAlertDialog(context, "Error getting license status");
    }
  }

  getLicenseStatus() async {
    try {
      var result = await ScanbotSdk.getLicenseStatus();
      showAlertDialog(context, jsonEncode(result), title: "License Status");
    } catch (e) {
      print(e);
      showAlertDialog(context, "Error getting OCR configs");
    }
  }

  importImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      await createPage(image.uri);
      gotoImagesView();
    } catch (e) {
      print(e);
    }
  }

  createPage(Uri uri) async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    var dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Processing");
    dialog.show();
    try {
      var page = await ScanbotSdk.createPage(uri, false);
      page = await ScanbotSdk.detectDocument(page);
      this._pageRepository.addPage(page);
    } catch (e) {
      print(e);
    } finally {
      dialog.hide();
    }
  }

  startDocumentScanning() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    DocumentScanningResult result;
    try {
      var config = DocumentScannerConfiguration(
        bottomBarBackgroundColor: Colors.blue,
        ignoreBadAspectRatio: true,
        acceptedAngleScore: 10,
        multiPageEnabled: true,
        autoSnappingSensitivity: 0.8,
        cameraPreviewMode: CameraPreviewMode.FIT_IN,
        orientationLockMode: CameraOrientationMode.PORTRAIT,
        cancelButtonTitle: "Cancel",
        pageCounterButtonTitle: "%d Page(s)",
        textHintOK: "Perfect, don't move...",
      );
      result = await ScanbotSdkUi.startDocumentScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result)) {
      _pageRepository.addPages(result.pages);
      gotoImagesView();
    }
  }

  startBarcodeScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    try {
      var config = BarcodeScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
        finderTextHint:
            "Please align any supported barcode in the frame to scan it.",
        // ...
      );
      var result = await ScanbotSdkUi.startBarcodeScanner(config);
      _showBarcodeScanningResult(result);
    } catch (e) {
      print(e);
    }
  }

  startQRScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    try {
      var config = BarcodeScannerConfiguration(
        barcodeFormats: [BarcodeFormat.QR_CODE],
        finderTextHint: "Please align a QR code in the frame to scan it.",
        // ...
      );
      var result = await ScanbotSdkUi.startBarcodeScanner(config);
      _showBarcodeScanningResult(result);
    } catch (e) {
      print(e);
    }
  }

  _showBarcodeScanningResult(final BarcodeScanningResult result) {
    if (isOperationSuccessful(result)) {
      showAlertDialog(
          context,
          "Format: " +
              result.barcodeFormat.toString() +
              "\nValue: " +
              result.text,
          title: "Barcode Result:");
    }
  }

  startMRZScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    MrzScanningResult result;
    try {
      var config = MrzScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
        // ...
      );
      result = await ScanbotSdkUi.startMrzScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result)) {
      var concatenate = StringBuffer();
      result.fields
          .map((field) =>
              "${field.name.toString().replaceAll("MRZFieldName.", "")}:${field.value}\n")
          .forEach((s) {
        concatenate.write(s);
      });
      showAlertDialog(context, concatenate.toString());
    }
  }

  gotoImagesView() async {
    imageCache.clear();
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DocumentPreview(_pageRepository)),
    );
  }
}
