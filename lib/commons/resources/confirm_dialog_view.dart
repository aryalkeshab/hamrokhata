import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';

class ConfirmDialogView extends StatelessWidget {
  const ConfirmDialogView({
    Key? key,
    required this.primaryText,
    this.secondaryText,
    required this.onApproveButtonPressed,
    required this.onCancelButtonPressed,
  }) : super(key: key);

  final String primaryText;
  final String? secondaryText;
  final VoidCallback onApproveButtonPressed;
  final VoidCallback onCancelButtonPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true), //false
      child: Center(
        child: BaseWidget(builder: (context, config, theme) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(
                vertical: 15, horizontal: config.appVerticalPaddingLarge()),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: BaseWidget(builder: (context, config, theme) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  config.verticalSpaceMedium(),
                  Text(primaryText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2),
                  config.verticalSpaceMedium(),
                  if (secondaryText != null)
                    Align(
                      alignment: Alignment.center,
                      child: Text('$secondaryText',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                  if (secondaryText != null) config.verticalSpaceMedium(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PrimaryOutlinedButton(
                          onPressed: onCancelButtonPressed,
                          title: 'No',
                        ),
                      ),
                      config.horizontalSpaceCustom(2),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: onApproveButtonPressed,
                          label: 'Yes',
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
