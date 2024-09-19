import 'package:app_financas/presentation/modules/create_objectivo/create_objectivo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DescricaoField extends StatelessWidget {
  const DescricaoField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateObjectivoBloc>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.description_outlined),
        ),
        const GutterSmall(),
        Expanded(
          child: TextFormField(
            initialValue: bloc.objectivoModel.description,
            onChanged: (v) {
              bloc.objectivoModel = bloc.objectivoModel.copyWith(
                description: v,
              );
            },
            maxLines: 3,
            focusNode: FocusNode(canRequestFocus: true),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'Descrição do objetivo',
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
