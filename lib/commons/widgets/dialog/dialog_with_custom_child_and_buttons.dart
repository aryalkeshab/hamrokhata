import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/resources/colors.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons/primary_btn_widget.dart';

Future<dynamic> dialogWithCustomChildAndTwoButton(
    {required BuildContext context,
    required String title,
    List<Widget>? child,
    String acceptText = "Yes",
    String rejectText = "No",
    required Function acceptFun,
    required Function rejectFun}) {
  return showDialog(
      context: context,
      builder: (context) =>
          Dialog(child: BaseWidget(builder: (context, config, theme) {
            return Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                    Visibility(
                      visible: child != null,
                      child: Column(children: child ?? []),
                    ),
                    config.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                            child: PrimaryBtnWidget(
                          title: rejectText,
                          verticalPadding: 12,
                          btnColor: Colors.black12,
                          textColor: primaryColor,
                          borderRadius: 4,
                          hasElevation: false,
                          onPressed: () {
                            rejectFun();
                          },
                        )),
                        config.horizontalSpaceSmall(),
                        Expanded(
                            child: PrimaryBtnWidget(
                          title: acceptText,
                          btnColor: primaryColor,
                          borderRadius: 4,
                          verticalPadding: 12,
                          onPressed: () {
                            acceptFun();
                          },
                        )),
                      ],
                    )
                  ],
                ));
          })));
}
