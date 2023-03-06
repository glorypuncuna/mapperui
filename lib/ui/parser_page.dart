import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

final _messageController = TextEditingController();
final _headerLengthController = TextEditingController();
final _formKey = GlobalKey<FormState>();
String _mode = "1";

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
                    left: 150, top: 10, right: 150, bottom: 10),
                padding: const EdgeInsets.only(
                    left: 0, top: 10, right: 0, bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [submitButton(), clearButton()],
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
  return SizedBox(
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
  );
}

Widget textField(String hint, String label, int maxL, TextInputType type,
    TextEditingController controller) {
  return TextFormField(
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
          child: ListTile(
            dense: true,
            title: const Text(
              '1 - With plain text (Whitespace counts!)',
              style: TextStyle(fontFamily: "VT323", fontSize: 15),
            ),
            leading: Radio(
              value: "satu",
              groupValue: _mode,
              onChanged: (value) {
                setState(() {
                  _mode = value as String;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 600,
          child: ListTile(
            dense: true,
            title: const Text(
                '2 - Hex except for the bitmap (Will delete whitespace)',
                style: TextStyle(fontFamily: "VT323", fontSize: 15)),
            leading: Radio(
              value: "dua",
              groupValue: _mode,
              onChanged: (value) {
                setState(() {
                  _mode = value as String;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 600,
          child: ListTile(
            dense: true,
            title: const Text(
                '3 - Hex only when the alpha exist in the data type (Will delete whitespace)',
                style: TextStyle(fontFamily: "VT323", fontSize: 15)),
            leading: Radio(
              value: "tiga",
              groupValue: _mode,
              onChanged: (value) {
                setState(() {
                  _mode = value as String;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget submitButton() {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () {},
      child: const Text(
        "Parse",
        style: TextStyle(fontFamily: "VT323"),
      ));
}

Widget clearButton() {
  return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text(
        "Clear All",
        style: TextStyle(fontFamily: "VT323"),
      ));
}
