import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF12306B);
  static const teal = Color(0xFF00A88F);
  static const surface = Colors.white;
  static const card = Color(0xFFF5F5F5);
  static const border = Color(0xFFE3E3E3);
  static const text = Color(0xFF1B1B1B);
  static const textMuted = Color(0xFF5F6368);
  static const badge = Color(0xFFE53935);
  static const checkoutGradient = LinearGradient(
    colors: [Color(0xFFF7841E), Color(0xFFFBB034)],
  );
}

abstract final class AppSpace {
  static const double xs = 4, s = 8, m = 16, l = 24, xl = 32;
}

abstract final class AppRadius {
  static const double card = 6, button = 4, pill = 999;
}

abstract final class AppShadows {
  static const soft = [
    BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
  ];
}
