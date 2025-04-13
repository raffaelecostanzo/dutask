import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiThemer extends StatelessWidget {
  const SystemUiThemer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final brightness = theme.brightness;
    final systemBarIconBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;

    final systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: colorScheme.surface,
      statusBarIconBrightness: systemBarIconBrightness,
      systemNavigationBarColor: colorScheme.surface,
      systemNavigationBarIconBrightness: systemBarIconBrightness,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: child,
    );
  }
}
