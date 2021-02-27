import 'package:flutter/material.dart';
import 'package:recipes/style/style.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(15.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: redTheme, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: redTheme, width: 2.3),
  ),
);