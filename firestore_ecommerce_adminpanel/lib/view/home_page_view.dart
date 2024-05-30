import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/admin_model.dart';
import '../tools/components/my_drawer.dart';
import '../tools/constants.dart';
import '../tools/controller/navigation_controller.dart';
import '../view_model/home_page_view_model.dart';

class HomePageView extends StatelessWidget with NavigationController {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      drawer: MyDrawer(
          onTap: () =>
              Provider.of<HomePageViewModel>(context, listen: false).logOut()),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("E-COMMERCE ADMİN PANEL"),
    );
  }

  _buildBody(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder(
            stream: Provider.of<HomePageViewModel>(context, listen: false)
                .getAdmin(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                List<AdminModel> admins = snapshot.data!;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "W E L C O M E",
                      style: Constants.getBoldColorStyle(
                          fontSize: 25, color: Colors.redAccent),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "A D M I N",
                      style: Constants.getBoldColorStyle(
                          fontSize: 25, color: Colors.redAccent),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      admins[0].adminEmail,
                      style: Constants.getBoldStyle(fontSize: 18),
                    )
                  ],
                );
              }
            },
          ),
          _buildFirstCardItem(context),
          _buildSecondCardItem(context)
        ],
      ),
    );
  }

  Widget _buildFirstCardItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goUsersPage(context: context);
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Card(
          elevation: 5,
          shadowColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.person_pin_outlined,
                size: 80,
              ),
              Text(
                "Kullanıcı Sayısı",
                style: Constants.getBoldStyle(fontSize: 18),
              ),
              Consumer<HomePageViewModel>(
                builder: (context, value, child) {
                  debugPrint("chip1 consumer çalıştı");

                  return Chip(
                      label: Text(
                    value.userCount.toString(),
                    style: Constants.getBoldStyle(fontSize: 20),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondCardItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goCategoriesPage(context: context);
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Card(
          elevation: 5,
          shadowColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.category_outlined,
                size: 80,
              ),
              Text(
                "Kategori Sayısı",
                style: Constants.getBoldStyle(fontSize: 18),
              ),
              Consumer<HomePageViewModel>(
                builder: (context, value, child) {
                  debugPrint("chip2  consumer çalıştı");

                  return Chip(
                      label: Text(
                    value.categoryCount.toString(),
                    style: Constants.getBoldStyle(fontSize: 20),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
