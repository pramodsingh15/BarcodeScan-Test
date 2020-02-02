import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcodescantest/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeClass extends StatefulWidget {
  @override
  _BarcodeClassState createState() => _BarcodeClassState();
}

class _BarcodeClassState extends State<BarcodeClass> {
  TextEditingController _scanTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Test"),

      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                            child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Scan Barcode",
                    border: OutlineInputBorder(),
                    
                  ),

                ),
              ),
              Expanded(
                child: Image(
                  image: AssetImage(
                    "images/barcode.png"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }

  Future scanItems(String title) async {
    try {
      String barcode = await BarcodeScanner.scan();
      if (title == "Equipment") {
        setState(() {
          _scanTextEditingController.text = barcode;
        });
      } 
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        Utility.showToastMsg("Camera permission not granted");
      } else {
        // Utility.showToastMsg("Unknown error: $e");
      }
    } on FormatException {
      // Utility.showToastMsg(
      //     'null (user returned using the "back-button" before scanning)');
    } catch (e) {
      // Utility.showToastMsg("Unknown error: $e");
    }
  }
}