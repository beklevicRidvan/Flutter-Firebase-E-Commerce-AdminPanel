import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../tools/constants.dart';

class UserEditView extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final dynamic controller3;

  const UserEditView(
      {super.key,
      required this.controller1,
      required this.controller2,
      this.controller3});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("EDİT PAGE"),
    );
  }

  _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: Constants.getNormalPadding(),
              child: _buildTextField1(controller1)),
          Container(
              margin: Constants.getNormalPadding(),
              child: _buildTextField2(controller2)),
          Container(
            margin: Constants.getNormalPadding(),
            child: controller3 != null
                ? _buildTextField3(controller3)
                : const Text(""),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffFF8A80))),
                  child: Text(
                    "IPTAL",
                    style: Constants.getBoldColorStyle(
                        fontSize: 17, color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    if (controller1.text.isNotEmpty &&
                        controller2.text.isNotEmpty) {
                      if (controller3 != null && controller3.text.isNotEmpty) {
                        Navigator.pop(context, [
                          controller1.text,
                          controller2.text,
                          controller3.text
                        ]);
                      }
                      Navigator.pop(
                          context, [controller1.text, controller2.text]);
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xff00E676))),
                  child: Text(
                    "TAMAM",
                    style: Constants.getBoldColorStyle(
                        fontSize: 17, color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  CupertinoTextField _buildTextField1(TextEditingController controller) {
    return CupertinoTextField(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.red, blurRadius: 5),
      ]),
      padding: Constants.getNormalPadding(),
      controller: controller,
    );
  }

  CupertinoTextField _buildTextField2(TextEditingController controller) {
    return CupertinoTextField(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.red, blurRadius: 5),
      ]),
      padding: Constants.getNormalPadding(),
      controller: controller,
    );
  }

  CupertinoTextField _buildTextField3(TextEditingController controller) {
    return CupertinoTextField(
      controller: controller,
      padding: Constants.getNormalPadding(),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.red, blurRadius: 5),
      ]),
    );
  }
}
