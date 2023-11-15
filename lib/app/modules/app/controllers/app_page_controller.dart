// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPageController extends GetxController {
  late BuildContext context;
  var index = 0.obs;

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  void setContext(BuildContext context) {
    this.context = context;
  }
}
