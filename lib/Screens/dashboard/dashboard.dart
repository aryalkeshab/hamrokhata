import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/dashboard_module.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: BaseWidget(
        builder: (context, config, theme) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingLarge(),
              ),
              child: Center(
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    padding: const EdgeInsets.all(8.0),
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    children: [
                      DashboardModule(
                        text: 'Product Details',
                        onPressed: () {
                          Get.toNamed(Routes.login);
                        },
                        icons: Icons.price_check_rounded,
                      ),
                      DashboardModule(
                        text: 'Purchase Order',
                        onPressed: () {
                          Get.toNamed(Routes.register);
                        },
                        icons: Icons.add_circle_rounded,
                      ),
                      DashboardModule(
                        text: 'Sales Order',
                        onPressed: () {
                          Get.toNamed(Routes.register);
                        },
                        icons: Icons.microwave_rounded,
                      ),
                      DashboardModule(
                        text: 'Sales Order List',
                        onPressed: () {
                          Get.toNamed(Routes.register);
                        },
                        icons: Icons.account_box,
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
