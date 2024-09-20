import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NomeObjectivoField extends StatelessWidget {
  const NomeObjectivoField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateObjectivoBloc>();
    final preObj = context.read<CreateObjectivoBloc>().objectivoModel;

    return Row(
      children: [
        const Icon(Icons.create_outlined),
        const GutterSmall(),
        Expanded(
          child: TextFormField(
            initialValue: preObj.name,
            onChanged: (v) {
              bloc.objectivoModel = bloc.objectivoModel.copyWith(
                name: v,
              );
            },
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Nome obrigatório';
              }
              return null;
            },
            focusNode: FocusNode(canRequestFocus: true),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'Nome do objetivo',
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
