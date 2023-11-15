import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_category_comp_controller.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BottomCategoryCompController>();

    return TextField(
      controller: controller.searchTextController,
      decoration: InputDecoration(
        hintText: 'Pesquisar',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            controller.searchTextController.clear();
          },
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Get.isDarkMode
            ? Theme.of(context).cardColor.withOpacity(.7)
            : Colors.grey.shade300,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gapPadding: 0,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gapPadding: 0,
        ),
      ),
    );
  }
}
