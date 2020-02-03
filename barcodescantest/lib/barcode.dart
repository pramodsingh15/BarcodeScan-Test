import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcodescantest/local_storage/shared_preference.dart';
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
  bool _isVisible = false;
  bool _isBtnVisible = false;
  List<String> list = [];
  List<String> list2 = [];
  List<String> list3 = [];

  @override
  void initState() {
    super.initState();
    getListData();
    print(list2.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Barcode Test"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8, top: 20),
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
                                setState(() {});
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
                          child: Image.asset(AppStrings.IMAGE_BARCODE),
                          onTap: () {
                            scanItems();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            child: Text(
                              "Show Saved Data",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blueAccent,
                            onPressed: () async {
                              list2 = await SharedPreferencesHelper
                                      .getSharedPreferencesHelperInstance()
                                  .getListString("key");
                              for (var i in list2) {
                                print("strValue -----> " + i);
                              }
                              if (list2.length != 0) {
                                setState(() {
                                  _isVisible = true;
                                });
                                print("list is visible");
                                print("${list2[0]}");
                              } else {
                                print("list is empty");
                              }
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              child: Text("Clear Data",
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (list2.length != 0) {
                                  SharedPreferencesHelper
                                          .getSharedPreferencesHelperInstance()
                                      .getClearData();
                                  print("Data cleared---->");
                                  Utility.showToastMsg(
                                      "Data cleared from local storage");
                                  setState(() {
                                    _isVisible = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: .5,
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Container(
                  height: 200,
                  child: ListView.builder(
                      itemCount: list3.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text("${index + 1})"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("${list3[index]}")
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
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
      addBarCode(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        Utility.showToastMsg(AppStrings.LABEL_CAMERA_DENIED);
      } else {
        Utility.showToastMsg(AppStrings.LABEL_UNKNOWN_ERROR + "$e");
      }
    } on FormatException {
      Utility.showToastMsg(AppStrings.LABEL_USER_BACK_BTN);
    } catch (e) {
      Utility.showToastMsg(AppStrings.LABEL_UNKNOWN_ERROR + "$e");
    }
  }

  addBarCode(String code) async {
    setState(() {
      if (list.length == 0) {
        list.add(code);
        SharedPreferencesHelper.getSharedPreferencesHelperInstance()
            .addListStringToSF("key", list);

        getData();
      } else {
        if (list.length > 0) {
          bool isExist = false;
          for (int i = 0; i < list.length; i++) {
            print(" data Exist in the  list---->" + list.elementAt(i));
            if (list.elementAt(i).contains(code)) {
              print(" Duplicate data Exist in the  list");
              isExist = true;
              break;
            }
          }
          if (!isExist) {
            print("Duplicate  not Exist");
            list.add(code);

            SharedPreferencesHelper.getSharedPreferencesHelperInstance()
                .addListStringToSF("key", list);
          } else {
            Utility.showToastMsg("Duplicate barCode");
          }
        }
      }
    });
  }

  getData() async {
    list2 = await SharedPreferencesHelper.getSharedPreferencesHelperInstance()
        .getListString("key");
    setState(() {
      list3.addAll(list2);
    });
    for (var i in list2) {
      print("strValue -----> " + i);
    }
    setState(() {
      _isVisible = true;
    });
  }

  getListData() async {
    list2 = await SharedPreferencesHelper.getSharedPreferencesHelperInstance()
        .getListString("key");
    if (list2.length != 0) {
      for (var i in list2) {
        print("strValue -----> " + i);
      }
    } else {
      print("list is empty");
    }
  }
}
