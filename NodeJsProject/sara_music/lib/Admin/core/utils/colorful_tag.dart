import 'dart:ui';

import 'package:flutter/material.dart';

Color getRoleColor(String? role) {
  if (role == "Doctor") {
    return Colors.green;
  } else if (role == "Violin Course") {
    return Colors.red;
  } else if (role == "Piano Course") {
    return Colors.blueAccent;
  } else if (role == "Oud Course") {
    return Colors.amberAccent;
  } else if (role == "Guitar Course") {
    return Colors.cyanAccent;
  } else if (role == "Voice Course") {
    return Colors.deepPurpleAccent;
  } 
  return Colors.black38;
}