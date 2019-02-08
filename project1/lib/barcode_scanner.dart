import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//JONATHAN:this package was added in the pubspec.yaml file - it downloads automatically
//Android permission: then we need to go to: android-app-src-main-androidmanifest.xml and add a permission for the camera
import 'package:barcode_scan/barcode_scan.dart';

class BarcodeScannerClass extends StatefulWidget {
  @override
  BarcodeScannerState createState() {
    return new BarcodeScannerState();
  }
}

class BarcodeScannerState extends State<BarcodeScannerClass> {
  String barcode = "No data";
  Future _scanQR() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
      ),
      body: Center(
        child: Text(
          barcode,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Press to scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
