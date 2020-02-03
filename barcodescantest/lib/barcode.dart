import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcodescantest/utility.dart';
import 'package:barcodescantest/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeClass extends StatefulWidget {
  @override
  _BarcodeClassState createState() => _BarcodeClassState();
}

class _BarcodeClassState extends State<BarcodeClass> {
  TextEditingController _scanBarcodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Test"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Expanded(
                flex: 9,
                child: TextFormField(
                    controller: _scanBarcodeController,
                    decoration: InputDecoration(
                        labelText: "Scan Barcode",
                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                    onChanged: (value) {
                      if (value.length >= 4) {
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            // _isEquipment = true;
                          });
                        });
                      }
                      validator:
                      (value) {
                        if (value.isEmpty) {
                          return AppStrings.LABEL_ERROR_BARCODE;
                        }
                      };
                    }),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: InkWell(
                    child: Image.asset("images/barcode.png"),
                    onTap: () {
                      print("barcode clicked");
                    
                      scanItems();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scanItems() async {
    try {
      String barcode = await BarcodeScanner.scan();     
        setState(() {
          _scanBarcodeController.text = barcode;
        });
      
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        Utility.showToastMsg(AppStrings.LABEL_CAMERA_DENIED);
      } else {
        Utility.showToastMsg(AppStrings.LABEL_UNKNOWN_ERROR+"$e");
      }
    } on FormatException {
      Utility.showToastMsg(
         AppStrings.LABEL_USER_BACK_BTN);
    } catch (e) {
      Utility.showToastMsg(AppStrings.LABEL_UNKNOWN_ERROR+"$e");
    }
  }
}
