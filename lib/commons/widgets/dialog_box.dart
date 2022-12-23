import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/utils/size_config.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';

void showSuccessAlertDialog(context,
    {required String title, required buttonLabel, String? content}) {
  showDialog(
    context: context,
    builder: (ctx) {
      final config = SizeConfig(context);
      return AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          SizedBox(
            width: config.appWidth(20),
            child: PrimaryButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              label: buttonLabel,
            ),
          ),
        ],
      );
    },
  );
}
