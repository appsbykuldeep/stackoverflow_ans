import 'package:flutter/material.dart';

extension AppContextExt on BuildContext {
  ThemeData get appTheme => Theme.of(this);
  TextTheme get textTheme => appTheme.textTheme;
  ColorScheme get scheme => appTheme.colorScheme;
  InputDecorationTheme get inputDecorationTheme =>
      appTheme.inputDecorationTheme;
  // Colors
  Color get primaryColor => scheme.primary;
  Color get onPrimaryColor => scheme.onPrimary;
  Color get onPrimaryContainerColor => scheme.onPrimaryContainer;
  Color get surfaceColor => scheme.surface;
  Color get onSurfaceColor => scheme.onSurface;
  Color get scaffoldBackgroundColor => appTheme.scaffoldBackgroundColor;

  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;

  double get appBarHeight => Scaffold.of(this).appBarMaxHeight ?? 0;

  // TextStyle
  /// label
  TextStyle? get labelSmall => textTheme.labelSmall;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// body
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// title
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// headline
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  TextScaler get textScaler => MediaQuery.of(this).textScaler;

  // media query
  Size get size => MediaQuery.of(this).size;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // Navigations

  Future<T?> push<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute<T>(
        builder: (context) => page,
      ),
    );
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute<T>(
        builder: (context) => page,
      ),
    );
  }

  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  Future<bool> maybePop<T>([T? result]) {
    return Navigator.maybePop(this, result);
  }
}
