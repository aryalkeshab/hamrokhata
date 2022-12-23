import 'package:flutter/material.dart';

class FocusNodeDisabler extends StatelessWidget {
  final Widget child;
  const FocusNodeDisabler({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: child);
  }
}
