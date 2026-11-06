import 'package:flutter/material.dart';

Widget profileButtons({child, onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.grey[200],
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
    ),
    child: child,
    onPressed: onPressed,
  );
}
