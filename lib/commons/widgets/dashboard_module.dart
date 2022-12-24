import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';

class DashboardModule extends HookWidget {
  final double? iconSize;

  final IconData? icons;
  final Function()? onPressed;
  final String? text;
  final double? borderRadius;
  final Color? boxBackgroundColor;

  const DashboardModule({
    Key? key,
    this.iconSize,
    this.icons,
    this.text,
    this.borderRadius,
    this.boxBackgroundColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(
            horizontal: config.appHorizontalPaddingMedium(),
            vertical: config.appHorizontalPaddingMedium()),
        decoration: BoxDecoration(
            color: boxBackgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(8.0, 8.0),
                  blurRadius: 8,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.grey.shade100,
                  offset: const Offset(-8.0, -8.0),
                  blurRadius: 8,
                  spreadRadius: 1.0),
            ]),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  icons,
                  size: iconSize ?? 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    text.toString(),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      );
    });

    //  Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     if (label != null)
    //       Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           if (prefixIcon != null)
    //             Padding(
    //                 padding: const EdgeInsets.only(right: 10.0),
    //                 child: prefixIcon!),
    //           Text(
    //             label!,
    //           ),
    //         ],
    //       ),
    //     SizedBox(
    //       height: labelHeight ?? 10,
    //     ),
    //     TextFormField(
    //       keyboardType: keyboardType,
    //       autovalidateMode: AutovalidateMode.onUserInteraction,
    //       validator: validator,
    //       onSaved: (value) {
    //         onSaved(value!);
    //       },
    //       onChanged: onChanged,
    //       obscureText: isPasswordVisible.value,
    //       decoration: InputDecoration(
    //         errorMaxLines: 2,
    //         prefixIcon: hintIcon,
    //         suffixIcon: isPassword!
    //             ? GestureDetector(
    //                 onTap: () {
    //                   isPasswordVisible.value = !isPasswordVisible.value;
    //                 },
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 15.0),
    //                   child: Icon(isPasswordVisible.value
    //                       ? Icons.visibility
    //                       : Icons.visibility_off),
    //                 ))
    //             : const SizedBox.shrink(),
    //         hintText: hintTxt,
    //         hintStyle: Theme.of(context)
    //             .textTheme
    //             .bodyText1
    //             ?.copyWith(color: disabledColor),
    //         filled: isFilled!,
    //         isDense: true,
    //         contentPadding:
    //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //         fillColor: Colors.white70,
    //         errorBorder: const OutlineInputBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //           borderSide: BorderSide(color: Colors.red),
    //         ),
    //         focusedErrorBorder: const OutlineInputBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //           borderSide: BorderSide(color: Colors.red),
    //         ),
    //         enabledBorder: OutlineInputBorder(
    //           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    //           borderSide: BorderSide(
    //             color: textFieldBorderColor ?? Theme.of(context).primaryColor,
    //           ),
    //         ),
    //         focusedBorder: OutlineInputBorder(
    //           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    //           borderSide: BorderSide(color: Theme.of(context).primaryColor),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
