import 'package:flutter/material.dart';


class ColorsDecoration extends BoxDecoration{
  static BoxDecoration loginDecoration = const BoxDecoration(
    gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 128, 47, 175),
              Color.fromARGB(255, 80, 43, 187),
              Color.fromARGB(192, 91, 67, 196)
            ])
  );
}