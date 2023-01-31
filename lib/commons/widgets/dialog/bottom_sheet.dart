import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';

bottomSheetSales({
  required BuildContext context,
  required List<Widget> children,
}) {
  Get.bottomSheet(BottomSheet(
    onClosing: () {},
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, bottomSheetSetState) {
        return Column(children: children);
      });
    },
  ));

  // return showDialog(
  //     context: context,
  //     builder: (context) =>
  //         Dialog(child: BaseWidget(builder: (context, config, theme) {
  //           return Padding(
  //             padding: const EdgeInsets.all(14),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 config.verticalSpaceSmall(),
  //                 Text(title,
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.headline4),
  //                 config.verticalSpaceMedium(),
  //                 Column(
  //                   children: children,
  //                 ),
  //               ],
  //             ),
  //           );
  //         })));
}
