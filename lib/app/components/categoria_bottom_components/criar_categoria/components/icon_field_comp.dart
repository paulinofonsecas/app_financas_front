import 'package:app_financas/app/components/categoria_bottom_components/criar_categoria/components/icon_picker_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';


class IconFieldComp extends StatelessWidget {
  const IconFieldComp({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Icon(
          Icons.photo,
          color: Colors.grey,
        ),
        const Gutter(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Icone',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gutter(),
              const IconPickerList(),
            ],
          ),
        ),
      ],
    );
  }
}
