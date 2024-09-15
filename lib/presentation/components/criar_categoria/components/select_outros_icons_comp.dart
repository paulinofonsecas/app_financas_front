import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/icon_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectOutrosIconsComponent extends StatelessWidget {
  const SelectOutrosIconsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IconFieldCubit>();

    return InkWell(
      onTap: () async {
        IconData? icon = await showIconPicker(
          context,
          iconPackModes: [IconPack.material],
          iconSize: 32,
          title: const Text('Selecione um Icone'),
          searchHintText: 'Pesquise um Icone (em inglês)',
          closeChild: const Text('Fechar'),
          noResultsText: 'Nenhum resultado encontrado',
        );

        if (icon != null) {
          cubit.selectIcon(icon);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 3.3,
          horizontal: kDefaultPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(90),
        ),
        child: Center(
          child: Text(
            'Outros Icones',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
