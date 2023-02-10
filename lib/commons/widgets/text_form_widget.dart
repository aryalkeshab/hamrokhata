import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hamrokhata/commons/resources/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? label;
  final String? hintTxt;
  final Widget? hintIcon;
  final Widget? suffixIcon;
  final bool? isFilled;

  final String? Function(String?)? validator;
  final VoidCallback onPressed;

  final Function(String)? onChanged;
  final Function(String) onSaved;
  final Widget? prefixIcon;
  final double? labelHeight;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  TextFieldWidget({
    super.key,
    this.hintTxt,
    this.hintIcon,
    this.controller,
    this.label,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    required this.onSaved,
    this.prefixIcon,
    this.labelHeight,
    this.isPassword = false,
    this.isFilled = false,
    this.keyboardType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 49,
              decoration: const BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  keyboardType: keyboardType,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validator,
                  controller: controller,
                  onSaved: (value) {
                    onSaved(value!);
                  },
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    prefixIcon: hintIcon,
                    hintText: hintTxt,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: disabledColor),
                    filled: isFilled!,
                    // border: Border.all(color: Colors.black),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    fillColor: Colors.white70,
                    errorBorder: const OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // borderRadius: const BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: textFieldBorderColor ??
                            Theme.of(context).primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderRadius:
                      //     const BorderRadius.all(Radius.circular(20.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 25,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
