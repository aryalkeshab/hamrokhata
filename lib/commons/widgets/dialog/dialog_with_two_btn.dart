import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons/primary_btn_widget.dart';

Future<dynamic> dialogWithTwoButton(
    {required BuildContext context,
    required String title,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  config.verticalSpaceSmall(),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4),
                  config.verticalSpaceMedium(),
                  Row(
                    children: [
                      Expanded(
                          child: PrimaryBtnWidget(
                        title: rejectText,
                        verticalPadding: 12,
                        btnColor: Colors.transparent,
                        textColor: Theme.of(context).primaryColor,
                        borderRadius: 4,
                        hasElevation: false,
                        onPressed: () {
                          rejectFun();
                        },
                      )),
                      config.verticalSpaceSmall(),
                      Expanded(
                          child: PrimaryBtnWidget(
                        title: acceptText,
                        btnColor: Colors.red,
                        borderRadius: 4,
                        verticalPadding: 12,
                        onPressed: () {
                          acceptFun();
                        },
                      )),
                    ],
                  )
                ],
              ),
            );
          })));
}
