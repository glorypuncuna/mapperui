import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mapperui/models/message.dart';

final _messageController = TextEditingController();
final _headerLengthController = TextEditingController();
final _outputController = TextEditingController();
final _formKey = GlobalKey<FormState>();
// bool _validateMess = false;
// bool _validateLen = false;
// bool _validateMode = false;
ModeType _mode = ModeType.satu;
final dio = Dio();

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
      body: Container(
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
                            textHeaderForField("Enter your ISO8583 message"),
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
                            width: 400,
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
      width: 600,
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
          width: 600,
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
          width: 600,
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
          width: 600,
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
  _outputController.text = response.data.toString();
}

@override
void dispose() {
  // Clean up the controller when the widget is disposed.
  _messageController.text = "";
  _headerLengthController.text = "";
  _outputController.text = "";
}
