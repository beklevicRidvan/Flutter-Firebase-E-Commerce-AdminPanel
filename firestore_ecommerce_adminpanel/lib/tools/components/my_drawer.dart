import 'package:flutter/material.dart';

import '../constants.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onTap;
  const MyDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 100, bottom: 25),
                child: Text(
                  "A D M I N  P A N E L",
                  style: Constants.getBoldStyle(fontSize: 25),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 40,
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "H O M E",
                            style: Constants.getBoldColorStyle(
                                fontSize: 20, color: Colors.white),
                          )),
                    ],
                  )),
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: GestureDetector(
                  onTap: () => onTap(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "L O G O U T",
                        style: Constants.getBoldStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
