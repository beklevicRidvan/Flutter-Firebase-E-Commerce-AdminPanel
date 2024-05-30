import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../tools/constants.dart';
import '../view_model/users_page_view_model.dart';

class UsersPageView extends StatelessWidget {
  const UsersPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: Constants.buildFloatingActionButton(
          () => context.read<UsersPageViewModel>().addUser(context)),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("USERS"),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<UsersPageViewModel>(
      builder: (context, value, child) {
        debugPrint("body consumer çalıştı");
        if (value.users.isNotEmpty) {
          return ListView.builder(
            itemCount: value.users.length,
            itemBuilder: (context, index) {
              var currentElement = value.users[index];
              return _buildListItem(context, index, currentElement);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Constants.circularProgressIndicatorColor,
            ),
          );
        }
      },
    );
  }

  _buildListItem(BuildContext context, int index, UserModel user) {
    return ExpansionTile(
      title: Text(user.userName),
      children: [
        Padding(
          padding: Constants.getNormalPadding(),
          child: Text(user.userEmail),
        ),
        _buildButtonRow(context, index)
      ],
    );
  }

  Widget _buildButtonRow(BuildContext context, int index) {
    UsersPageViewModel viewModel =
        Provider.of<UsersPageViewModel>(context, listen: false);
    return Padding(
      padding: Constants.getLittlePadding(),
      child: ButtonBar(
        children: [
          IconButton(
              onPressed: () {
                viewModel.updateData(context, index);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      ButtonBar(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "IPTAL",
                                style: Constants.getBoldColorStyle(
                                    fontSize: 17, color: Colors.white),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                viewModel.deleteData(index);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "TAMAM",
                                style: Constants.getBoldColorStyle(
                                    fontSize: 17, color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.clear)),
        ],
      ),
    );
  }
}
