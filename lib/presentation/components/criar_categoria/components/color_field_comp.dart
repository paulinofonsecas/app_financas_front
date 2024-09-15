// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_picker_list.dart';

class ColorFieldComp extends StatelessWidget {
  const ColorFieldComp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorFieldState = context.watch<ColorFieldCubit>().state;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.color_lens,
          color: colorFieldState is ColorFieldSelected
              ? colorFieldState.color
              : Colors.grey,
        ),
        Gutter(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cor',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gutter(),
              ColorPickerList(),
            ],
          ),
        ),
      ],
    );
  }
}
