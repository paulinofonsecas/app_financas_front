// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BottomSheetContasWidget extends StatefulWidget {
  const BottomSheetContasWidget({
    Key? key,
  }) : super(key: key);

  static Future<dynamic> openModalBottomSheet(
    BuildContext context,
  ) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: true,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return BottomSheetContasWidget();
      },
    );
  }

  @override
  State<BottomSheetContasWidget> createState() => _BottomSheetContaWidget();
}

class _BottomSheetContaWidget extends State<BottomSheetContasWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: const [
          
        ],
      ),
    );
  }
}
