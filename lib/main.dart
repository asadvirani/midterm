import 'package:flutter/material.dart';


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midterm/Product.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      useMaterial3: true,
    ),
    home: const ProductUi()

  ));
}

