import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../resources/colors.dart';

class PrimaryFormField extends HookWidget {
  final String? label;
  final String? hintTxt;
  final Widget? hintIcon;
  final bool? isFilled;

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String) onSaved;
  final Widget? prefixIcon;
  final double? labelHeight;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const PrimaryFormField({
    Key? key,
    this.hintTxt,
    this.hintIcon,
    this.controller,
    this.label,
    this.validator,
    this.onChanged,
    required this.onSaved,
    this.prefixIcon,
    this.labelHeight,
    this.isPassword = false,
    this.isFilled = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(isPassword!);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null)
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: prefixIcon!),
              Text(
                label!,
              ),
            ],
          ),
        SizedBox(
          height: labelHeight ?? 10,
        ),
        TextFormField(
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          onSaved: (value) {
            onSaved(value!);
          },
          onChanged: onChanged,
          obscureText: isPasswordVisible.value,
          decoration: InputDecoration(
            errorMaxLines: 2,
            prefixIcon: hintIcon,
            suffixIcon: isPassword!
                ? GestureDetector(
                    onTap: () {
                      isPasswordVisible.value = !isPasswordVisible.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Icon(isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ))
                : const SizedBox.shrink(),
            hintText: hintTxt,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: disabledColor),
            filled: isFilled!,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            fillColor: Colors.white70,
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: textFieldBorderColor ?? Theme.of(context).primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
