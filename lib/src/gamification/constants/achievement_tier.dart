import 'package:flutter/material.dart';

enum AchievementTier {
  bronze(Color(0xFFCD7F32)),
  silver(Color(0xFFC0C0C0)),
  gold(Color(0xFFFFD700));

  final Color color;
  const AchievementTier(this.color);
}
