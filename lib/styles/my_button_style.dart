import 'package:flutter/material.dart';

ButtonStyle myButtonStyle(double width, double height) {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(
      Size(width, height), // Chỉnh kích thước nút thành 120 chiều rộng và 40 chiều cao
    ),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      )),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.yellow.withOpacity(0.04);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return Colors.yellow.withOpacity(0.12);
            }
            return null;
          }));
}