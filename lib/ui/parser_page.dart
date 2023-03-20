import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mapperui/models/message.dart';

import '../models/field.dart';
import '../models/res.dart';

final _messageController = TextEditingController();
final _headerLengthController = TextEditingController();
final _outputController = TextEditingController();
final _formKey = GlobalKey<FormState>();
// bool _validateMess = false;
// bool _validateLen = false;
// bool _validateMode = false;
ModeType _mode = ModeType.satu;
final dio = Dio();
double size = 400;
double size2 = 600;

enum ModeType { satu, dua, tiga }

class ParserPage extends StatefulWidget {
  const ParserPage({super.key});
  @override
  State<ParserPage> createState() => _ParserPageState();
}

class _ParserPageState extends State<ParserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: const Text(
                      "ISO8583 Parser",
                      style: TextStyle(
                          fontFamily: 'VT323',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 50, top: 10, right: 50, bottom: 10),
                    padding: const EdgeInsets.only(
                        left: 50, top: 10, right: 10, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textHeaderForField(
                                    "Enter your ISO8583 message"),
                              ],
                            ),
                            formMessage(),
                            const TileRad(),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  submitButton(),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  clearButton()
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, top: 10, right: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textHeaderForField("Output"),
                              SizedBox(
                                width: size2,
                                child: SingleChildScrollView(
                                  child: textField(
                                    'Output will be shown here',
                                    'Output',
                                    21,
                                    TextInputType.multiline,
                                    _outputController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))),
        ),
      ),
    );
  }
}

Widget textHeaderForField(String field) {
  return Container(
    padding: const EdgeInsets.only(left: 50, top: 10, right: 50, bottom: 10),
    child: Center(
      child: Text(
        field,
        style: const TextStyle(fontFamily: 'VT323', fontSize: 20),
      ),
    ),
  );
}

Widget formMessage() {
  return Flexible(
    child: SizedBox(
      width: size,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textField('Enter your ISO8583 message here', 'Message', 5,
                TextInputType.multiline, _messageController),
            textField("Put your header length", "Header Length", 1,
                TextInputType.number, _headerLengthController)
          ],
        ),
      ),
    ),
  );
}

Widget textField(String hint, String label, int maxL, TextInputType type,
    TextEditingController controller,
    {bool enable = true}) {
  return TextFormField(
    enabled: enable,
    style: const TextStyle(color: Colors.black, fontFamily: "VT323"),
    keyboardType: type,
    maxLines: maxL,
    controller: controller,
    textCapitalization: TextCapitalization.characters,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      border: const OutlineInputBorder(),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black, fontFamily: "VT323"),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black, fontFamily: "VT323"),
      // errorText: validate ? 'Value Can\'t Be Empty' : null,
      // errorStyle: const TextStyle(color: Colors.red, fontFamily: "VT323"),
    ),
  );
}

class TileRad extends StatefulWidget {
  const TileRad({super.key});

  @override
  State<TileRad> createState() => _TileRadState();
}

class _TileRadState extends State<TileRad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textHeaderForField("Choose your mode"),
          ],
        ),
        SizedBox(
          width: size,
          child: RadioListTile<ModeType>(
            dense: true,
            title: const Text(
              '1 - With plain text (Whitespace counts!)',
              style: TextStyle(fontFamily: "VT323", fontSize: 15),
            ),
            value: ModeType.satu,
            groupValue: _mode,
            onChanged: (value) {
              setState(() {
                _mode = value!;
              });
            },
          ),
        ),
        SizedBox(
          width: size,
          child: RadioListTile<ModeType>(
            dense: true,
            title: const Text(
                '2 - Hex except for the bitmap (Will delete whitespace)',
                style: TextStyle(fontFamily: "VT323", fontSize: 15)),
            value: ModeType.dua,
            groupValue: _mode,
            onChanged: (value) {
              setState(() {
                _mode = value!;
              });
            },
          ),
        ),
        SizedBox(
          width: size,
          child: RadioListTile<ModeType>(
            dense: true,
            title: const Text(
                '3 - Hex only when the alpha exist in the data type (Will delete whitespace)',
                style: TextStyle(fontFamily: "VT323", fontSize: 15)),
            value: ModeType.tiga,
            groupValue: _mode,
            onChanged: (value) {
              setState(() {
                _mode = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}

Widget submitButton() {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () {
        int modeType;
        if (_mode == ModeType.satu) {
          modeType = 1;
        } else if (_mode == ModeType.dua) {
          modeType = 2;
        } else {
          modeType = 3;
        }
        ISOInput input = ISOInput(
            iso: _messageController.text,
            mode: modeType,
            lengthHeader: int.parse(_headerLengthController.text));
        String data = jsonEncode(input);
        String url = "http://localhost:8080/v1/iso/mode3/";
        if (modeType == 2) {
          url = "http://localhost:8080/v1/iso/mode2/";
        } else if (modeType == 1) {
          url = "http://localhost:8080/v1/iso/mode1/";
        }
        request(url, data);
      },
      child: const Text(
        "Parse",
        style: TextStyle(fontFamily: "VT323"),
      ));
}

Widget clearButton() {
  return ElevatedButton(
      onPressed: () {
        dispose();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text(
        "Clear All",
        style: TextStyle(fontFamily: "VT323"),
      ));
}

void request(String url, String data) async {
  Response response;
  response = await dio.post(url, data: data);
  // _outputController.text = response.toString();
  Map<String, dynamic> resMap = jsonDecode(response.toString());
  var res = Res.fromJson(resMap);
  String tpdu = res.data.header.toString();
  String mti = res.data.mti.toString();
  String bitmap = res.data.bitmap.bit;
  String print = "TPDU      : " +
      tpdu +
      "\nMTI       : " +
      mti +
      "\n            ISO Version            : " +
      res.data.mtiMess.isoVersion +
      "\n            Message Class          : " +
      res.data.mtiMess.messageClass +
      "\n            Message Function       : " +
      res.data.mtiMess.messageFunction +
      "\n            Message Origin         : " +
      res.data.mtiMess.messageOrigin +
      "\nP-BITMAP  : " +
      bitmap;

  int lenDe = res.data.dataElement.length;
  for (int i = 0; i < lenDe; i++) {
    int lengthVal = res.data.dataElement[i].value.length;
    String fieldPrint = "";
    if (res.data.dataElement[i].id < 10) {
      fieldPrint = "\nFIELD  ${res.data.dataElement[i].id}  : ";
    } else {
      fieldPrint = "\nFIELD ${res.data.dataElement[i].id}  : ";
    }

    int length = 4 + res.data.dataElement[i].value.length;
    if (lengthVal > 99) {
      length += 2;
    } else if (lengthVal > 9) {
      length += 1;
    }
    int space = 0;
    if (length < 35) {
      space = 35 - length;
    }

    String values = res.data.dataElement[i].value;
    Map<int, int> customSpec = getSpec();
    if (customSpec.containsKey(res.data.dataElement[i].id)) {
      values = spec(res, i);
      // if (res.data.dataElement[i].id == 59) {
      //   lengthVal = res.data.dataElement[i].value.length -
      //       "-".allMatches(res.data.dataElement[i].value).length;
      // }
      lengthVal = (res.data.dataElement[i].length / 2) as int;
    }

    Map<int, int> mapper = getMap();
    if (!mapper.containsKey(res.data.dataElement[i].id)) {
      fieldPrint += values;
      space += res.data.dataElement[i].length.toString().length + 3;
    } else {
      fieldPrint += "($lengthVal) ${values}";
    }

    for (int j = 0; j < space; j++) {
      fieldPrint += " ";
    }
    if (space == 0) {
      fieldPrint += "\n";
    }

    print += "$fieldPrint(${res.data.dataElement[i].label})";
  }

  _outputController.text = print;
}

@override
void dispose() {
  // Clean up the controller when the widget is disposed.
  _messageController.text = "";
  _headerLengthController.text = "";
  _outputController.text = "";
}

Map<int, int> getMap() {
  var newMap = {
    2: 0,
    32: 0,
    33: 0,
    34: 0,
    35: 0,
    36: 0,
    44: 0,
    45: 0,
    46: 0,
    47: 0,
    48: 0,
    54: 0,
    55: 0,
    56: 0,
    57: 0,
    58: 0,
    59: 0,
    60: 0,
    61: 0,
    62: 0,
    63: 0,
    99: 0,
    100: 0,
    101: 0,
    102: 0,
    103: 0,
    104: 0,
    105: 0,
    106: 0,
    107: 0,
    108: 0,
    109: 0,
    110: 0,
    111: 0,
    112: 0,
    113: 0,
    114: 0,
    115: 0,
    116: 0,
    117: 0,
    118: 0,
    119: 0,
    120: 0,
    121: 0,
    122: 0,
    123: 0,
    124: 0,
    125: 0,
    126: 0,
    127: 0
  };

  return newMap;
}

Map<int, int> getSpec() {
  var newMap = {4: 0, 59: 0};
  return newMap;
}

String spec(Res res, int i) {
  String result = "";
  Field field = res.data.dataElement[i];
  if (field.id == 4) {
    int money = int.parse(field.value);
    return "RP $money,00";
  }
  if (field.id == 59) {
    String mti = res.data.mti;
    String data = res.data.dataElement[i].value;
    final splitted = data.split('-');
    if (mti == "0200") {
      for (int j = 0; j < splitted.length; j++) {
        switch (j) {
          case 0:
            result += "\n            EDC Type              : " + splitted[j];
            break;
          case 1:
            result += "\n            Software Name         : " + splitted[j];
            break;
          case 2:
            result += "\n            TRN Struk Customer    : " + splitted[j];
            break;
          case 3:
            result += "\n            TRN Struk Merchant    : " + splitted[j];
            break;
          case 4:
            result += "\n            Serial Number         : " + splitted[j];
            break;
          case 5:
            result += "\n            Memory                : " + splitted[j];
            break;
          case 6:
            result += "\n            Version ID            : " + splitted[j];
            break;
          case 7:
            result += "\n            Original Trans Date   : " + splitted[j];
            break;
          case 8:
            result += "\n            Original Trans Time   : " + splitted[j];
            break;
          case 9:
            result += "\n            Trace Number          : " + splitted[j];
            break;
          case 10:
            result += "\n            Tran Duration         : " + splitted[j];
            break;
          case 11:
            result += "\n            Dial Type             : " + splitted[j];
            break;
          case 12:
            result += "\n            Dial Success Count    : " + splitted[j];
            break;
          case 13:
            result += "\n            Dial Total Count      : " + splitted[j];
            break;
          case 14:
            result += "\n            Total Approve         : " + splitted[j];
            break;
          case 15:
            result += "\n            Total Decline         : " + splitted[j];
            break;
        }
      }
    }
    if (mti == "0210") {
      for (int j = 0; j < splitted.length; j++) {
        switch (j) {
          case 0:
            result += "\n            Batch Number        : " + splitted[j];
            break;
          case 1:
            result += "\n            Year                : " + splitted[j];
            break;
          case 2:
            result += "\n            Reserve             : " + splitted[j];
            break;
        }
      }
    }
  }
  return result;
}
