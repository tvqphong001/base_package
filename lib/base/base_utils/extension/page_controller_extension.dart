import 'package:flutter/material.dart';

extension PageControllerEx on PageController {
  void animate2Page(int page) {
    animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
