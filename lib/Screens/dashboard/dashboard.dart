import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/dashboard_module.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              showSuccessToast('Successfully logged out. ');
              Get.offNamed(Routes.login);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: BaseWidget(
        builder: (context, config, theme) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingLarge(),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/app_logo.png"),
                    ),
                    config.verticalSpaceMedium(),
                    GridView.count(
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
                              Get.toNamed(Routes.productDetails);
                            },
                            icons: Icons.price_check_rounded,
                          ),
                          DashboardModule(
                            text: 'Purchase Order',
                            onPressed: () {
                              Get.toNamed(Routes.purchaseOrder);
                            },
                            icons: Icons.add_circle_rounded,
                          ),
                          DashboardModule(
                            text: 'Sales Order',
                            onPressed: () {
                              Get.toNamed(Routes.salesOrder);
                            },
                            icons: Icons.microwave_rounded,
                          ),
                          DashboardModule(
                            text: 'Sales Order List',
                            onPressed: () {
                              Get.toNamed(Routes.salesOrderList);
                            },
                            icons: Icons.account_box,
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
