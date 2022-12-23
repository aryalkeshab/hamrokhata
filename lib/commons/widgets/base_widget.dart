import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hamrokhata/commons/utils/size_config.dart';

// This widget is for screen component (item/widget) build
class BaseWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizeConfig config, ThemeData themeData) builder;

  const BaseWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);
    final themeData = Theme.of(context);
    return builder(context, config, themeData);
  }
}

/// base hook widget class for hook based shared,
///
/// provides same information as BaseWidget provides like (theme, sizeConfig
class HookBaseWidget extends HookWidget {
  final Widget Function(
      BuildContext context, SizeConfig config, ThemeData themeData) builder;

  const HookBaseWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);
    final themeData = Theme.of(context);
    return builder(context, config, themeData);
  }
}

// *
// (BuildContext context, SizeConfig sizeConfig,ThemeData theme)
// *//

// abstract class BaseWidgetTest extends Widget {
//   /// Initializes [key] for subclasses.
//   const BaseWidgetTest({ Key? key }) : super(key: key);
//
//   @protected
//   Widget build(BuildContext context);
// }
