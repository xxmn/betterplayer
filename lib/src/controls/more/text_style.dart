import 'package:flutter/widgets.dart';

TextStyle getTextStyle(bool isSelected, Color overflowModalTextColor) {
  return TextStyle(
    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
    color: isSelected ? overflowModalTextColor : overflowModalTextColor.withOpacity(0.7),
  );
}
