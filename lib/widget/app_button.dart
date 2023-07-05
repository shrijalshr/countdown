import 'package:flutter/material.dart';

import '../widget/tap_effect.dart';
import '../common/export.dart';

enum AppButtonState { primary, secondary, disabled }

///
/// Takes full parent width. Make sure to wrap with Expanded or Flex when using in a row or similar widgets.
///
/// Use the default constructor for primary button
///
/// Use the corresponding factory constructors for the secondary and disabled state as
///
/// ```AppButton()``` for primary
///
/// ```AppButton.secondary()``` for secondary
///
/// ```AppButton.disabled()``` for disabled state
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 52,
    this.borderRadius = 30,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 12,
    ),
    this.buttonState = AppButtonState.primary,
    this.labelColor,
    this.isClickable = false,
    this.borderColor,
  });
  final double height;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final Widget label;
  final bool? isClickable;
  final Color? labelColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  /// Specifies the primary, secondary and disabled state of [AppButton].
  ///
  /// Pass [buttonState] on specific scenarios only as
  /// ```
  /// AppButton(
  ///     onPressed: () {},
  ///     label: AppString.getStartedText,
  ///     buttonState: isEnabled ? AppButtonState.primary : AppButtonState.disabled,
  /// )
  /// ```
  /// Else use the corresponding factory constructor instead.
  final AppButtonState buttonState;

  factory AppButton.secondary({
    required VoidCallback onPressed,
    required Widget label,
    double height = 52,
    double borderRadius = 30,
    bool isClickable = false,
    Color? borderColor,
    double elevation = 0,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 12,
    ),
  }) {
    return AppButton(
      onPressed: onPressed,
      label: label,
      buttonState: AppButtonState.secondary,
      height: height,
      borderRadius: borderRadius,
      elevation: elevation,
      borderColor: borderColor,
      isClickable: isClickable,
      padding: padding,
      labelColor: AppColor.light.primaryColor,
    );
  }
  factory AppButton.disabled({
    required Widget label,
    double height = 52,
    double borderRadius = 30,
    double elevation = 0,
    Color? borderColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 12,
    ),
  }) {
    return AppButton(
      onPressed: () {},
      label: label,
      buttonState: AppButtonState.disabled,
      height: height,
      isClickable: false,
      borderColor: borderColor,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).extension<AppColor>()!;
    return TapEffect(
      isClickable: isClickable ?? false,
      onClick: () {},
      child: ElevatedButton(
        onPressed: buttonState == AppButtonState.disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonState == AppButtonState.primary
              ? appColor.primaryColor
              : appColor.backgroundColor,
          foregroundColor: buttonState == AppButtonState.primary
              ? appColor.backgroundColor
              : appColor.primaryColor,
          disabledBackgroundColor: appColor.primaryColor.withOpacity(0.5),
          disabledForegroundColor: appColor.backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: buttonState == AppButtonState.secondary
                ? BorderSide(
                    color: borderColor ?? appColor.primaryColor,
                  )
                : BorderSide.none,
          ),
          padding: padding,
          minimumSize: Size.fromHeight(height),
          shadowColor: Colors.transparent,
          textStyle: context.textStyles.labelMedium!.apply(
            color: buttonState == AppButtonState.primary
                ? appColor.backgroundColor
                : appColor.primaryColor,
          ),
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }
}
