import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';

Future<dynamic> dialogWithCustomChild(
    {required BuildContext context,
    required String title,
    List<Widget>? child}) {
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
                  Visibility(
                    visible: child != null,
                    child: Row(children: child ?? []),
                  )
                ],
              ),
            );
          })));
}